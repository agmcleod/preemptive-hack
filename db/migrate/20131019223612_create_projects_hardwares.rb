class CreateProjectsHardwares < ActiveRecord::Migration
  def change
    create_table :projects_hardwares do |t|
      t.integer :project_id
      t.integer :hardware_id

      t.timestamps
    end
  end
end
