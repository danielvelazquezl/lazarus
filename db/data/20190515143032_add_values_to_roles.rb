class AddValuesToRoles < ActiveRecord::Migration[5.2]
  def up
    Role.create(
        :name => "admin"
    )
    Role.create(
        :name => "Producción"
    )
    Role.create(
        :name => "User"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
