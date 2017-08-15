class Warehouse < ApplicationRecord
	validates :name, presence: true
  has_many :documents
  has_many :commodity_warehouse_relationships
end
