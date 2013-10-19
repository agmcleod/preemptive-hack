class HackdayOrganization < ActiveRecord::Base
  validates :name, presence: true
end
