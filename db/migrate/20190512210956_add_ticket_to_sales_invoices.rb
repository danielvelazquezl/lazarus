class AddTicketToSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_invoices, :order_ticket_id, :integer
  end
end
