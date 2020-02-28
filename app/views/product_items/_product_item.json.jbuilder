json.extract! product_item, :id, :quantity, :product_id, :created_at, :updated_at
json.url product_item_url(product_item, format: :json)
