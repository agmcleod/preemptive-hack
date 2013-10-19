class AddHackdayIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hackday_id, :integer
  end
end
