class AddResource < ActiveRecord::Migration[5.2]
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
        :name => "MovementProof",
        :alias => "Movimientos"
    )
    Resource.create(
        :name => "Stock",
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
        :name => "Provider",
        :alias => "Proveedores"
    )
    Resource.create(
        :alias => "Facturas de Ventas",
        :name => "SalesInvoice"
    )
    Resource.create(
        :name => "OrderTicket",
        :alias => "Nota de Pedidos"
    )
    Resource.create(
        :name => "PurchaseRequest",
        :alias => "Pedido de Compras"
    )
    Resource.create(
        :name => "BudgetRequest",
        :alias => "Pedido de Cotización"
    )
    Resource.create(
        :name => "PurchaseOrder",
        :alias => "Orden de Compra"
    )
    Resource.create(
        :name => "PurchaseInvoice",
        :alias => "Facturas de Compra"
    )

    Resource.create(
        :name => "CashMovement",
        :alias => "Movimiento de Caja"
    )
    Resource.create(
        :name => "Cash",
        :alias => "Cajas"
    )
    Resource.create(
        :name => "OpenCloseCash",
        :alias => "Apertura y Cierre de Cajas"
    )
    Resource.create(
        :name => "Report",
        :alias => "Reportes"
    )

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
