class HardwaresHackdays < ActiveRecord::Base
  belongs_to :hardware
  belongs_to :hackday

  validates_uniqueness_of :hardware_id, scope: :hackday_id
end
