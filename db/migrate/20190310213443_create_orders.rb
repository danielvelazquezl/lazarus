class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :person, foreign_key: true
      t.references :origin
      t.references :destination
      t.string :order_type
      t.datetime :date_request
      t.datetime :date_finished
      t.string :state

      t.timestamps
    end
  end
end
