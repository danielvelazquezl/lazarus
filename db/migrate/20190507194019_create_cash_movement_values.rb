class CreateCashMovementValues < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_movement_values do |t|
      t.integer :ammount

      t.timestamps
    end
  end
end
