class ProjectsHardware < ActiveRecord::Base
  belongs_to :project
  belongs_to :hardware

  validates_uniqueness_of :hardware_id, scope: :project_id
end
