class CommodityWarehouseRelationshipsController < ApplicationController

  def index
    @cws = CommodityWarehouseRelationship.all
    if params[:search].present?
      @cws = @cws.query(params[:search].to_s)
    end
    @cws = @cws.page(params[:page])
  end
  
  def warning
    cw_ids = Array.new
    CommodityWarehouseRelationship.all.each do |c|
      if c.stock_quantity >= c.commodity.high_stock || c.stock_quantity <= c.commodity.low_stock
        cw_ids.push(c.id)
      end
    end
    @cws = CommodityWarehouseRelationship.where('id in (?)', cw_ids).page(params[:page])
  end
end