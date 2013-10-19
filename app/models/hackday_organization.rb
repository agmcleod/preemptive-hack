class HackdayOrganization < ActiveRecord::Base
  has_many :hackdays
  has_many :users_hackday_organizations
  has_many :users, through: :users_hackday_organizations

  validates :name, presence: true
end
