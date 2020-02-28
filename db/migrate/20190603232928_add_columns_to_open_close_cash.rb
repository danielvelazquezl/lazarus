class AddColumnsToOpenCloseCash < ActiveRecord::Migration[5.2]
  def change
    add_column :open_close_cashes, :check_amount, :integer
    add_column :open_close_cashes, :card_amount, :integer
    add_column :open_close_cashes, :bill_amount, :integer
  end
end
