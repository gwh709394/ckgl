json.extract! warehouse, :id, :name, :code, :location, :remark, :created_at, :updated_at
json.url warehouse_url(warehouse, format: :json)
