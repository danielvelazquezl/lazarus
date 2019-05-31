class RemoveCashIdFromCashMovementValues < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movement_values, :cash_id, :integer
    remove_column :cash_movement_values, :payment_id, :integer
  end
end
