class CommodityWarehouseRelationship < ApplicationRecord
  belongs_to :commodity
  belongs_to :warehouse

  def self.query
  end
  
  def self.update_stock(w_id, c_id, quantity)
    cw = CommodityWarehouseRelationship.where('warehouse_id=? and commodity_id=?', w_id, c_id).first
    if cw.present?
      cw.update_attributes(stock_quantity: cw.stock_quantity + quantity)
    else
      CommodityWarehouseRelationship.create(warehouse_id: w_id, commodity_id: c_id, stock_quantity: quantity)
    end
  end
end
