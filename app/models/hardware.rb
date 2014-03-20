class Hardware < ActiveRecord::Base
  has_many :hardwares_hackdays, class_name: HardwaresHackdays
  has_many :hackdays, through: :hardwares_hackdays
  has_many :projects_hardware
  has_many :projects, through: :projects_hardware
  has_many :organization_hardwares
  has_many :hackday_organizations, through: :organization_hardwares

  validates :name, presence: true, uniqueness: true

  class << self
    def for_hackday_organization(hackday_organization)
      hardwares = hackday_organization.hardwares.to_a
      (Hardware.where('id NOT IN ( SELECT hardware_id FROM organization_hardwares )').to_a + hardwares).sort { |a, b| a.name <=> b.name }
    end
  end
end
