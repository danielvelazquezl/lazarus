class AddAliasToResource < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :alias, :string
  end
end
