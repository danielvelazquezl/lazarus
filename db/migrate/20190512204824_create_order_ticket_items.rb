class CreateOrderTicketItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_ticket_items do |t|
      t.references :order_ticket, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :request_quantity
      t.integer :pending_quantity

      t.timestamps
    end
  end
end
