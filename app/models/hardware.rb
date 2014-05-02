class Hardware < ActiveRecord::Base
  has_many :hardwares_hackdays, class_name: HardwaresHackdays
  has_many :hackdays, through: :hardwares_hackdays
  has_many :projects_hardware
  has_many :projects, through: :projects_hardware
  has_many :organization_hardwares
  has_many :hackday_organizations, through: :organization_hardwares

  validates :name, presence: true, uniqueness: true
end
