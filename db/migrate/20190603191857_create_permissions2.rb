class CreatePermissions2 < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.references :role, foreign_key: true
      t.references :resource, foreign_key: true
      t.boolean :action_read
      t.boolean :action_create
      t.boolean :action_update
      t.boolean :action_destroy

      t.timestamps
    end
  end
end
