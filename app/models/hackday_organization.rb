class HackdayOrganization < ActiveRecord::Base
  has_many :hackdays
  validates :name, presence: true
end
