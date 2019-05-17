class AddNewValuesToTypeActions < ActiveRecord::Migration[5.2]
  def up
    TypeAction.create(
        :name => "read"
    )
    TypeAction.create(
        :name => "update"
    )
    TypeAction.create(
        :name => "destroy"
    )
    TypeAction.create(
        :name => "edit"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
