class CreateCashMovementInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_movement_invoices do |t|
      t.integer :ammount

      t.timestamps
    end
  end
end
