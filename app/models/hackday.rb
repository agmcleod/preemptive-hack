class Hackday < ActiveRecord::Base
  belongs_to :hackday_organization
  has_many :projects, dependent: :destroy
  has_many :hardwares_hackdays, class_name: HardwaresHackdays, dependent: :destroy
  has_many :hardwares, through: :hardwares_hackdays

  delegate :name, to: :hackday_organization, prefix: true, allow_nil: true

  validates :name, presence: true
  validates :start_date, presence: true
  validates :hackday_organization, presence: true
  validate :start_before_end

  def decorator
    @decorator ||= HackdayDecorator.new(self)
  end

  def end_date_formatted
    decorator.end_date_formatted
  end

  def hackday_organization_hardwares
    hackday_organization.hardwares
  end

  def has_hardware?(hardware)
    has_hardware_id?(hardware.id)
  end

  def has_hardware_id?(id)
    decorator.has_hardware_id?(id)
  end

  def is_member?(user)
    decorator.is_member? user
  end

  def is_owner?(owner)
    decorator.is_owner? owner
  end

  def start_date_formatted
    decorator.start_date_formatted
  end

  def sync_hardware(ids_hash)
    decorator.sync_hardware(ids_hash)
  end

private
  def start_before_end
    if end_date && start_date >= end_date
      errors.add(:start_date, "Must be before the end date")
    end
  end
end
