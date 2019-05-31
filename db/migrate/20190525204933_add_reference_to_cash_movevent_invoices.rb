class AddReferenceToCashMoveventInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :cash_movement_invoices, :sales_invoices, foreign_key: true
  end
end
