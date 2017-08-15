class CommodityWarehouseRelationship < ApplicationRecord
  belongs_to :commodity
  belongs_to :warehouse

  def self.query
  end
end
