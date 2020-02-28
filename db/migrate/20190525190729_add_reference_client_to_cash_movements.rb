class AddReferenceClientToCashMovements < ActiveRecord::Migration[5.2]
  def change
    add_reference :cash_movements, :clients, foreign_key: true
    add_reference :cash_movements, :cashes, foreign_key: true
  end
end
