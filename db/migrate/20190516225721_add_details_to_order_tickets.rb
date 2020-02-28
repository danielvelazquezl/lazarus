class AddDetailsToOrderTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :order_tickets, :date, :datetime
    add_column :order_tickets, :observation, :string
    add_column :order_tickets, :state, :string
  end
end
