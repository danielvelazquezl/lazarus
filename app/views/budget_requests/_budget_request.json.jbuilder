json.extract! budget_request, :id, :provider_id, :employee_id, :date, :state, :comment, :created_at, :updated_at
json.url budget_request_url(budget_request, format: :json)
