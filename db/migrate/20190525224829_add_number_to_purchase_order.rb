class AddNumberToPurchaseOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_orders, :number, :integer
  end
end
