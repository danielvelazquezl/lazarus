class AddOrderTicketToSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales_invoices, :order_tickets, foreign_key: true
    add_reference :sales_invoices, :pay_methods, foreign_key: true
  end
end
