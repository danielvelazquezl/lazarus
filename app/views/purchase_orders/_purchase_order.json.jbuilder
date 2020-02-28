json.extract! purchase_order, :id, :provider_id, :employee_id, :date, :state, :comment, :created_at, :updated_at
json.url purchase_order_url(purchase_order, format: :json)
