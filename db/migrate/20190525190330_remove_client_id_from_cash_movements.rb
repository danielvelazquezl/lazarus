class RemoveClientIdFromCashMovements < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movements, :client_id
  end
end
