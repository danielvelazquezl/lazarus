json.extract! order, :id, :type, :date_request, :date_finished, :state, :created_at, :updated_at
json.url order_url(order, format: :json)
