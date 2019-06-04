json.extract! purchase_invoice, :id, :provider_id, :date, :total, :iva, :balance, :invoice_number, :stamped, :deposit_id, :pay_method_id, :purchase_order_id, :created_at, :updated_at
json.url purchase_invoice_url(purchase_invoice, format: :json)
