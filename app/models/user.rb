class User < ActiveRecord::Base
  has_many :users_hackday_organizations
  has_many :hackday_organizations, through: :users_hackday_organizations
  has_many :hackday_organizations_owners
  has_many :owned_hackday_organizations, through: :hackday_organizations_owners, class_name: HackdayOrganization, source: :hackday_organization

  class << self
    def available_users(hackday_organization_id)
      ids = UsersHackdayOrganization.where(hackday_organization_id: hackday_organization_id).collect(&:user_id)
      ids = ids + HackdayOrganizationsOwner.where(hackday_organization_id: hackday_organization_id).collect(&:user_id)
      User.where('id NOT IN (?)', ids).order(:username)
    end
    def guest_account
      User.where(username: 'guestaccount', email: 'guestaccount@example.com').first_or_create
    end
  end
end
