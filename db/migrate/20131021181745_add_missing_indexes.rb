class AddMissingIndexes < ActiveRecord::Migration
  def change
    ActiveRecord::Base.transaction do
      add_index :hackdays, :hackday_organization_id
      add_index :hardwares, :hackday_organization_id
      add_index :hardwares_hackdays, :hardware_id
      add_index :hardwares_hackdays, :hackday_id
      add_index :projects, :hackday_id
      add_index :projects_hardwares, :project_id
      add_index :projects_hardwares, :hardware_id
      add_index :users_hackday_organizations, :user_id
      add_index :users_hackday_organizations, :hackday_organization_id
    end
  end
end
