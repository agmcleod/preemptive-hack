class CreateUsersHackdayOrganizations < ActiveRecord::Migration
  def change
    create_table :users_hackday_organizations do |t|
      t.integer :user_id
      t.integer :hackday_organization_id

      t.timestamps
    end
  end
end
