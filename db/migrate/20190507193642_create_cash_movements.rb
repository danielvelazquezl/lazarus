class CreateCashMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_movements do |t|
      t.datetime :date
      t.string :comments
      t.integer :total

      t.timestamps
    end
  end
end
