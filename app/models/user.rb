class User < ActiveRecord::Base
  has_many :users_hackday_organizations
  has_many :hackday_organizations, through: :users_hackday_organizations
  has_many :hackday_organizations_owners
  has_many :owned_hackday_organizations, through: :hackday_organizations_owners, class_name: HackdayOrganization, source: :hackday_organization

  attr_accessor :test_user

  attr_reader :password

  validates_confirmation_of :password, if: :not_test_user
  validates_presence_of :password_digest, if: :not_test_user

  include InstanceMethodsOnActivation

  if respond_to?(:attributes_protected_by_default)
    def self.attributes_protected_by_default
      super + ['password_digest']
    end
  end

  validates :password, presence: true, on: :create, if: :not_test_user
  validates :email, presence: true, format: /\A.+@.+\..+\z/i
  validates :username, presence: true, uniqueness: true

  class << self
    def available_users(hackday_organization_id)
      ids = UsersHackdayOrganization.where(hackday_organization_id: hackday_organization_id).collect(&:user_id)
      ids = ids + HackdayOrganizationsOwner.where(hackday_organization_id: hackday_organization_id).collect(&:user_id)
      User.where('id NOT IN (?)', ids).order(:username)
    end
  end

private

  def not_test_user
    !test_user
  end

end
