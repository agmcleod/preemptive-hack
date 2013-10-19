class CreateHardwares < ActiveRecord::Migration
  def change
    create_table :hardwares do |t|
      t.string :name
      t.integer :hackday_organization_id

      t.timestamps
    end
  end
end
