class DelCashesFromCashMovements < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movements, :cashes_id
    remove_column :cash_movements, :clients_id
    add_reference :cash_movements, :client, foreign_key: true

  end
end
