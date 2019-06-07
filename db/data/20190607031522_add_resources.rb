class AddResources < ActiveRecord::Migration[5.2]
  def up

    Resource.create(
        :name => "Product",
        :alias => "Productos"
    )
    Resource.create(
        :name => "Form",
        :alias => "Formularios"
    )
    Resource.create(
        :name => "Order",
        :alias => "Ordenes"
    )
    Resource.create(
        :name => "MovementProofs",
        :alias => "Movimientos"
    )
    Resource.create(
        :name => "Stocks",
        :alias => "Stocks"
    )
    Resource.create(
        :name => "Client",
        :alias => "Clientes"
    )
    Resource.create(
        :name => "Employee",
        :alias => "Empleados"
    )
    Resource.create(
        :name => "Providers",
        :alias => "Proveedores"
    )
    Resource.create(
        :alias => "Facturas de Ventas",
        :name => "SalesInvoices"
    )
    Resource.create(
        :name => "OrderTickes",
        :alias => "Nota de Pedidos"
    )
    Resource.create(
        :name => "PurchaseRequests",
        :alias => "Pedido de Compras"
    )
    Resource.create(
        :name => "BudgetRequests",
        :alias => "Pedido de Cotización"
    )
    Resource.create(
        :name => "PurchaseOrders",
        :alias => "Orden de Compra"
    )
    Resource.create(
        :name => "PurchaseInvoices",
        :alias => "Facturas de Compra"
    )

    Resource.create(
        :name => "CashMovements",
        :alias => "Movimiento de Caja"
    )
    Resource.create(
        :name => "Cashes",
        :alias => "Cajas"
    )
    Resource.create(
        :name => "OpenCloseCashes",
        :alias => "Apertura y Cierre de Cajas"
    )
    Resource.create(
        :name => "Reports",
        :alias => "Reportes"
    )

  end


  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
