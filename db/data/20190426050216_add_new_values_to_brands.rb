class AddNewValuesToBrands < ActiveRecord::Migration[5.2]
  def up
    Brand.create([{description: 'Samsung'}, {description: 'Sate'}, {description: 'Kingston'},
                  {description: 'LG'}, {description: 'HP'}, {description: 'Acer'},
                  {description: 'Toshiba'}, {description: 'Intel'}, {description: 'AMD'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
