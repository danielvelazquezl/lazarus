json.extract! product, :id, :product_type, :description, :unit_cost, :created_at, :updated_at
json.url product_url(product, format: :json)
