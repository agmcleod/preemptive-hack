class Project < ActiveRecord::Base

  belongs_to :hackday
  has_many :projects_hardware, dependent: :destroy
  has_many :hardwares, through: :projects_hardware
  validates :name, presence: true

  class << self
    def create_from_project(id, hackday_id)
      old_project = find_or_return id
      project = Project.new old_project.attributes.merge(hackday_id: hackday_id)
      project.id = nil
      Project.transaction do
        old_project.hardwares.each do |hardware|
          project.hardwares << hardware
        end
        project.save!
      end
      project
    end

    def create_from_project_or_new(existing_project_id, project_params)
      if existing_project_id.present?
        create_from_project existing_project_id.to_i, project_params[:hackday_id]
      else
        Project.new project_params
      end
    end

    def find_or_return(value)
      if value.is_a? Numeric
        Project.find value
      else
        value
      end
    end
  end

  def hackday_organization
    hackday && hackday.hackday_organization
  end

  def has_hardware_id?(id)
    hardwares.collect(&:id).include? id
  end
end
