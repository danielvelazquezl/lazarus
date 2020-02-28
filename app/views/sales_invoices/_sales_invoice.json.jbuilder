json.extract! sales_invoice, :id, :employee_id, :date, :client_id, :total, :iva, :balance, :invoice_number, :stamped, :deposit, :created_at, :updated_at
json.url sales_invoice_url(sales_invoice, format: :json)
