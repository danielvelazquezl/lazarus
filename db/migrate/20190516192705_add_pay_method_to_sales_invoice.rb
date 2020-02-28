class AddPayMethodToSalesInvoice < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales_invoices, :order_ticket, foreign_key: true
    add_reference :sales_invoices, :pay_method, foreign_key: true
  end
end
