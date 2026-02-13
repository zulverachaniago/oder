json.extract! product, :id, :name, :product_category_id, :product_type_id, :slug, :created_at, :updated_at
json.url product_url(product, format: :json)
