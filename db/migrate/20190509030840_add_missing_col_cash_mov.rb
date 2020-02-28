class AddMissingColCashMov < ActiveRecord::Migration[5.2]
  def change
    #cash_movement_invoice
    add_column :cash_movement_invoices, :cash_id, :integer
    #cash_movement_values
    add_column :cash_movement_values, :cash_id, :integer
    add_column :cash_movement_values, :payment_id, :integer
  end
end
