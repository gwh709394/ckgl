json.extract! stock, :id, :code, :commodity_id, :stock_type_id, :warehouse_id, :price, :quantity, :sum, :summary, :s_date, :created_at, :updated_at
json.url stock_url(stock, format: :json)
