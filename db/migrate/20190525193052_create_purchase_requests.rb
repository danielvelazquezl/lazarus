class CreatePurchaseRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_requests do |t|
      t.datetime :date
      t.references :employee, foreign_key: true
      t.string :state
      t.string :comment

      t.timestamps
    end
  end
end
