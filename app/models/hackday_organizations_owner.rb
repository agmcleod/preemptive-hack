class HackdayOrganizationsOwner < ActiveRecord::Base
  belongs_to :hackday_organization
  belongs_to :user
end
