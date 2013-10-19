class Hackday < ActiveRecord::Base
  belongs_to :hackday_organization
  has_many :projects
  include HackdayConcerns

  default_scope lambda { order('start_date desc') }

  validates :start_date, presence: true
  validate :start_before_end

private
  def start_before_end
    if end_date && start_date >= end_date
      errors.add(:start_date, "Must be before the end date")
    end
  end
end
