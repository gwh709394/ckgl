class HomeController < ApplicationController
  def welcome
    @documents = Document.limit(10).order(id: :desc)

    cw_ids = Array.new
    CommodityWarehouseRelationship.all.each do |c|
      if c.stock_quantity >= c.commodity.high_stock || c.stock_quantity <= c.commodity.low_stock
        cw_ids.push(c.id)
      end
    end
    @cws = CommodityWarehouseRelationship.where('id in (?)', cw_ids).page(params[:page])
  
  end
end
