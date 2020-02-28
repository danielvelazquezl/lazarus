class AddNewValuesToSettings < ActiveRecord::Migration[5.2]
  def up
    Setting.create([{key: 'id_components_deposit', value: '1'},{key: 'id_products_deposit', value: '2'},{key: 'id_production_deposit', value: '3'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
