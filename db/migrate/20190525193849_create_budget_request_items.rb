class CreateBudgetRequestItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_request_items do |t|
      t.references :budget_request, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :price
      t.integer :requested_quantity
      t.integer :pending_quantity

      t.timestamps
    end
  end
end
