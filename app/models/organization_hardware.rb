class OrganizationHardware < ActiveRecord::Base
  belongs_to :hardware
  belongs_to :hackday_organization
end
