class AddStampedFromSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales_invoices, :stamped, foreign_key: true
  end
end
