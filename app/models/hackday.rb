class Hackday < ActiveRecord::Base
  belongs_to :hackday_organization
  has_many :projects, dependent: :destroy
  has_many :hardwares_hackdays, class_name: HardwaresHackdays, dependent: :destroy
  has_many :hardwares, through: :hardwares_hackdays

  delegate :name, to: :hackday_organization, prefix: true, allow_nil: true

  include HackdayDecorator

  validates :name, presence: true
  validates :start_date, presence: true
  validates :hackday_organization, presence: true
  validate :start_before_end

  def hackday_organization_hardwares
    hackday_organization.hardwares
  end

private
  def start_before_end
    if end_date && start_date >= end_date
      errors.add(:start_date, "Must be before the end date")
    end
  end
end
