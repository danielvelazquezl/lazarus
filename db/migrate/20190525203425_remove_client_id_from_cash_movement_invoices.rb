class RemoveClientIdFromCashMovementInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movement_invoices, :cash_id
  end
end
