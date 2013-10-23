class HackdayOrganization < ActiveRecord::Base
  has_many :hackdays, -> { order("start_date desc") }, dependent: :destroy
  has_many :users_hackday_organizations
  has_many :users, through: :users_hackday_organizations
  has_many :projects, through: :hackdays
  has_many :hardwares, -> { order(:name) }
  has_many :hackday_organizations_owners
  has_many :owners, through: :hackday_organizations_owners, class_name: User, source: :user

  validates :name, presence: true
  validate :at_least_one_owner

  def create_test_user
    users.build username: Faker::Internet.user_name, email: Faker::Internet.email
    save
  end
  
  def is_member?(user)
    members.include? user
  end

  def is_owner?(user)
    owners.include? user
  end
  
  def members
    owners + users
  end

  def next_hackday
    hackdays.first
  end

private

  def at_least_one_owner
    errors.add(:base, "must have at least one owner") if owners.empty?
  end

end
