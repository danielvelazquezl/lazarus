class AddCashToCashMovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :cash_movements, :cash, foreign_key: true
  end
end
