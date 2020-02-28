class AddValuesToPeople < ActiveRecord::Migration[5.2]
  def up
    Person.create([{name: 'Roberto Rumbo'}, {name: 'Paula Almendro'}, {name: 'Melanie Meziane'},
                   {name: 'Juan Echeveste'}, {name: 'Veronica Cubas'}, {name: 'Amanda Bah'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
