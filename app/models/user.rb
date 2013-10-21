class User < ActiveRecord::Base
  has_many :users_hackday_organizations
  has_many :hackday_organizations, through: :users_hackday_organizations

  class << self
    def guest_account
      User.where(username: 'guestaccount', email: 'guestaccount@example.com').first_or_create
    end
  end
end
