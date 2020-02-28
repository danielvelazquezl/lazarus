class AddNumberToForms < ActiveRecord::Migration[5.2]
  def change
    add_column :forms, :number, :integer
  end
end
