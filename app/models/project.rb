class Project < ActiveRecord::Base
  belongs_to :hackday
  has_many :projects_hardware
  has_many :hardwares, through: :projects_hardware
  validates :name, presence: true
  validates :description, presence: true

  class << self
    def create_from_project(id)
      old_project = Project.find id
      project = Project.new
      project.attributes = old_project.attributes
      project.id = nil
      project.save!
      project
    end

    def create_from_project_or_new(existing_project_id, project_params)
      if existing_project_id.present?
        create_from_project existing_project_id
      else
        new project_params
      end
    end
  end

  def hackday_organization
    hackday && hackday.hackday_organization
  end
end
