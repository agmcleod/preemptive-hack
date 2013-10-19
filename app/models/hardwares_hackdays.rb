class HardwaresHackdays < ActiveRecord::Base
  belongs_to :hardware
  belongs_to :hackday
end
