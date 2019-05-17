class AddValuesToProductCategories < ActiveRecord::Migration[5.2]
  def up
    ProductCategory.create([{description: 'Teclado'}, {description: 'Monitor'}, {description: 'Memoria'},
                               {description: 'Disco Duro'}, {description: 'Terminado'}, {description: 'Mouse'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
