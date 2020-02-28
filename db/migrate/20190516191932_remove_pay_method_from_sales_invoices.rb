class RemovePayMethodFromSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_reference :sales_invoices, :order_tickets, foreign_key: true
    remove_reference :sales_invoices, :pay_methods, foreign_key: true
  end
end
