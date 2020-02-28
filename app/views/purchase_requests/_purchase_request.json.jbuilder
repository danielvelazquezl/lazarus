json.extract! purchase_request, :id, :date, :employee_id, :state, :comment, :created_at, :updated_at
json.url purchase_request_url(purchase_request, format: :json)
