class AddNewValuesToPayMethods < ActiveRecord::Migration[5.2]
  def up
    PayMethod.create([{description:'Efectivo'},{description:'Tarjeta de credito'} ,
                      {description: 'Cheque'}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
