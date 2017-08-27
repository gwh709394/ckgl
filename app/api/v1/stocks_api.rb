require 'uri'
require 'net/http'

module V1
  class StocksApi < Grape::API
    namespace :stocks do
      format :json
      
      
      params do
        optional :name, type: String, desc: "Commoditiy"
      end
      get do
        stocks = Stock.where('warehouse_id is not null').order(created_at: :desc)
        if params[:name].present?
          stocks = stocks.query(params[:name].to_s)
        end
        if stocks.present?
          { 
            result: 1, 
            message: Stock.api_render(stocks) }
        else 
          { result: 0, message: "暂无数据" }
        end
      end
      
      
    end
  end
end