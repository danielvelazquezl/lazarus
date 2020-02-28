class CreateOrderTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :order_tickets do |t|
      t.references :client, foreign_key: true
      t.integer :ticket_number
      t.references :employee, foreign_key: true
      t.references :pay_method, foreign_key: true

      t.timestamps
    end
  end
end
