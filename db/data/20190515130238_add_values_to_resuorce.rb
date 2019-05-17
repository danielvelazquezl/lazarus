class AddValuesToResuorce < ActiveRecord::Migration[5.2]
  def up

    Resource.create(
        :name => "Brand"
    )
    Resource.create(
        :name => "CashMovement"
    )
    Resource.create(
        :name => "Client"
    )
    Resource.create(
        :name => "Desposit"
    )
    Resource.create(
        :name => "Employee"
    )
    Resource.create(
        :name => "Form"
    )
    Resource.create(
        :name => "MovementProofDetail"
    )
    Resource.create(
        :name => "MovementProof"
    )
    Resource.create(
        :name => "MovementType"
    )
    Resource.create(
        :name => "Order"
    )
    Resource.create(
        :name => "People"
    )
    Resource.create(
        :name => "Permission"
    )
    Resource.create(
        :name => "ProductCategorie"
    )
    Resource.create(
        :name => "ProductItem"
    )
    Resource.create(
        :name => "Product"
    )
    Resource.create(
        :name => "Provider"
    )
    Resource.create(
        :name => "Role"
    )
    Resource.create(
        :name => "SalesInvoice"
    )
    Resource.create(
        :name => "Stock"
    )
    Resource.create(
        :name => "User"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
