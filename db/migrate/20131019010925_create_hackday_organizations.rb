class CreateHackdayOrganizations < ActiveRecord::Migration
  def change
    create_table :hackday_organizations do |t|
      t.string :name

      t.timestamps
    end
  end
end
