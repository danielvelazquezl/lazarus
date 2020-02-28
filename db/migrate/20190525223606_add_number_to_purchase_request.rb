class AddNumberToPurchaseRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_requests, :number, :integer
  end
end
