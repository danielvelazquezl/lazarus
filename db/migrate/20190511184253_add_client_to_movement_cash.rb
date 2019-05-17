class AddClientToMovementCash < ActiveRecord::Migration[5.2]
  def change
    add_column :cash_movements, :client_id, :integer
  end
end
