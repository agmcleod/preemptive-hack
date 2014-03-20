class CreateOrganizationHardwares < ActiveRecord::Migration
  def change
    create_table :organization_hardwares do |t|
      t.integer :hackday_organization_id
      t.integer :hardware_id

      t.timestamps
    end
  end
end
