class AddColumnToOpenClose < ActiveRecord::Migration[5.2]
  def change
    add_column :open_close_cashes,  :state, :boolean
  end
end
