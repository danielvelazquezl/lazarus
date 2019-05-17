class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.references :type_action, foreign_key: true
      t.references :role, foreign_key: true
      t.references :resource, foreign_key: true

      t.timestamps
    end
  end
end
