class DropProductProvider < ActiveRecord::Migration[5.2]
  def change
    drop_table :product_providers
  end
end
