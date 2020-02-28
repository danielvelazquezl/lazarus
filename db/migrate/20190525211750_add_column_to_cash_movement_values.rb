class AddColumnToCashMovementValues < ActiveRecord::Migration[5.2]
  def change
    add_column :cash_movement_values, :card_number, :integer
    add_reference :cash_movement_values, :bank, foreign_key: true
    add_column :cash_movement_values, :drawer, :string
    add_column :cash_movement_values, :account_number, :string
    add_column :cash_movement_values, :check_number, :integer
    add_column :cash_movement_values, :emission_date, :date
    add_column :cash_movement_values, :due_date, :date
    add_reference :cash_movement_values, :pay_method, foreign_key: true
    add_reference :cash_movement_values, :cash_movement, foreign_key: true
  end
end
