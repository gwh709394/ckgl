class CommodityWarehouseRelationshipsController < ApplicationController

  def index
    @cws = CommodityWarehouseRelationship.all
    if params[:search].present?
      @cws = @cws.query(params[:search].to_s)
    end
    @cws = @cws.page(params[:page])
  end
end