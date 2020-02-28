class AddNewValuesToBank < ActiveRecord::Migration[5.2]
  def up
    Bank.create([{name: 'Banco Regional'} , {name: 'Itau'},
                 {name: 'Itapua'} , {name: 'Cefisa'} , {name: 'Vision'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
