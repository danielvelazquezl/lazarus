json.extract! order_ticket, :id, :client_id, :ticket_number, :employee_id, :pay_method_id, :date, :observation, :state, :created_at, :updated_at
json.url order_ticket_url(order_ticket, format: :json)
