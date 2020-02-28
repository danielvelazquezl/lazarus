class AddRolesForEmployees < ActiveRecord::Migration[5.2]
  def up
    Role.create([{id: 2, name: 'cachier'},
                 {id: 3, name: 'warehouse_manager'},
                 {id: 4, name: 'seller'},
                 {id: 5, name: 'manager'},
                 {id: 6, name: 'external_employee'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
