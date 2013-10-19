class UsersHackdayOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :hackday_organization
end
