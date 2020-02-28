class AddReferencePurchaseRequestToPurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchase_orders, :purchase_request, foreign_key: true
  end
end
