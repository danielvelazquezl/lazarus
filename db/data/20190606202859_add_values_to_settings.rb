class AddValuesToSettings < ActiveRecord::Migration[5.2]
  def up
    Setting.create([{key: 'cashier', value: '2'},
                    {key: 'warehouse_manager', value: '3'},
                    {key: 'seller', value: '4'},
                    {key: 'manager', value: '5'},
                    {key: 'external_employee', value: '6'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
