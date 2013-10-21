class HackdayOrganization < ActiveRecord::Base
  has_many :hackdays, -> { order("start_date desc") }, dependent: :destroy
  has_many :users_hackday_organizations
  has_many :users, through: :users_hackday_organizations
  has_many :projects, through: :hackdays
  has_many :hardwares, -> { order(:name) }

  validates :name, presence: true

  def create_test_user
    users.build username: Faker::Internet.user_name, email: Faker::Internet.email
    save
  end

  def next_hackday
    hackdays.first
  end
end
