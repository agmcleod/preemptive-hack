class CreateHackdays < ActiveRecord::Migration
  def change
    create_table :hackdays do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :hackday_organization_id
      t.string :location

      t.timestamps
    end
  end
end
