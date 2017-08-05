json.extract! commodity, :id, :name, :code, :commodity_type_id, :bar_code, :specification, :unit, :created_at, :updated_at
json.url commodity_url(commodity, format: :json)
