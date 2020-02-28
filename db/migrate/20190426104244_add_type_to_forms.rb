class AddTypeToForms < ActiveRecord::Migration[5.2]
  def change
    add_column :forms, :type, :string
  end
end
