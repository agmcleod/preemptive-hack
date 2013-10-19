class Project < ActiveRecord::Base
  belongs_to :hackday
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
  end

  def hackday_organization
    hackday && hackday.hackday_organization
  end
end
