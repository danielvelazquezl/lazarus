class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.references :person, foreign_key: true
      t.integer :orig_deposit
      t.integer :dest_deposit
      t.datetime :date
      t.string :comments

      t.timestamps
    end
  end
end
