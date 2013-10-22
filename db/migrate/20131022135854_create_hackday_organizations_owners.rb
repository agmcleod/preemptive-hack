class CreateHackdayOrganizationsOwners < ActiveRecord::Migration
  def change
    create_table :hackday_organizations_owners do |t|
      t.integer :hackday_organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
