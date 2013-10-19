class HackdayOrganization < ActiveRecord::Base
  has_many :hackdays, -> { order: "start_date desc" }
  has_many :users_hackday_organizations
  has_many :users, through: :users_hackday_organizations
  has_many :projects, through: :hackdays
  has_many :hardwares

  validates :name, presence: true

  def next_hackday
    hackdays.first
  end
end
