class AddColumnToOpenCloseCashes < ActiveRecord::Migration[5.2]
  def change
    add_reference :open_close_cashes, :cash, foreign_key: true
    rename_column :open_close_cashes, :fina_date, :final_date
  end
end
