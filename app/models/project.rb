class Project < ActiveRecord::Base

  belongs_to :hackday
  has_many :projects_hardware
  has_many :hardwares, through: :projects_hardware
  include ProjectDecorator
  validates :name, presence: true
  validates :description, presence: true

  class << self
    def create_from_project(id)
      old_project = ProjectDecorator.find_or_return id
      project = Project.new old_project.attributes
      project.id = nil
      Project.transaction do
        old_project.hardwares.each do |hardware|
          project.hardwares << hardware
        end
        project.save
      end
      project
    end

    def create_from_project_or_new(existing_project_id, project_params)
      if existing_project_id.present?
        create_from_project existing_project_id.to_i
      else
        Project.new project_params
      end
    end
  end
end
