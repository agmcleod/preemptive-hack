class Hardware < ActiveRecord::Base
  belongs_to :hackday_organization
  validates :name, presence: true, uniqueness: true

  class << self
    def for_hackday_organization(hackday_organization_id)
      Hardware.where('hackday_organization_id IS NULL OR hackday_organization_id = ?', hackday_organization_id).order(:name)
    end
  end
end
