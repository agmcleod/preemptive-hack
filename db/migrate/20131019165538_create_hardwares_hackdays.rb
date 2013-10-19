class CreateHardwaresHackdays < ActiveRecord::Migration
  def change
    create_table :hardwares_hackdays do |t|
      t.integer :hardware_id
      t.integer :hackday_id

      t.timestamps
    end
  end
end
