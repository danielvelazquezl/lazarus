class AddColumnToOpenCloseCash < ActiveRecord::Migration[5.2]
  def change
    add_column :open_close_cashes, :balance, :integer
  end
end
