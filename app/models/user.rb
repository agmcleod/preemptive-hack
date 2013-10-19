class User < ActiveRecord::Base
  has_many :users_hackday_organizations
  has_many :hackday_organizations, through: :users_hackday_organizations

  class << self
    def create_test_user(hackday_organization_id)
      hackday_organization = HackdayOrganization.find(hackday_organization_id.to_i)
      hackday_organization.users.build(username: Faker::Internet.user_name, email: Faker::Internet.email)
      hackday_organization.save
    end
  end
end
