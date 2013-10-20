class Project < ActiveRecord::Base
  belongs_to :hackday
  has_many :projects_hardware
  has_many :hardwares, through: :projects_hardware
  include ProjectConcerns
  validates :name, presence: true
  validates :description, presence: true

  class << self
    def create_from_project(id)
      old_project = Project.find id
      project = Project.new
      project.attributes = old_project.attributes
      project.id = nil
      Project.transaction do
        project.save!
        old_project.projects_hardware.each do |projects_hardware|
          projects_hardware.update_attribute(:project_id, project.id)
        end
      end
      project.reload
    end

    def create_from_project_or_new(existing_project_id, project_params)
      if existing_project_id.present?
        create_from_project existing_project_id
      else
        Project.new project_params
      end
    end
  end
end
