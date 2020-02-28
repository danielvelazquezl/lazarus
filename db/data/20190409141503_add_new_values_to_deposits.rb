class AddNewValuesToDeposits < ActiveRecord::Migration[5.2]
  def up
    Deposit.create([{id: '1', description: 'Deposito 1'},{id: '2', description: 'Deposito 2'},{id: '3', description: 'Produccion'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
