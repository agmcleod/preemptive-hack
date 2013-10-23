class AddNameToHackdays < ActiveRecord::Migration
  def change
    add_column :hackdays, :name, :string
  end
end
