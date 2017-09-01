class Stock < ApplicationRecord
  belongs_to :document
  belongs_to :commodity
  paginates_per 15
  def self.query s
    q = "%#{s}%"
    a = Commodity.where('name like ?', q).map { |x| x.id }
    Stock.where('commodity_id in (?)', a)
  end
  
  def self.query_stock_type st
    a = Document.where(stock_type_id: st).map { |x| x.id }
    Stock.where('document_id in (?)', a)
  end
  
  def self.api_render stocks
    array = []
    stocks.each do |stock|
      hash = Hash.new
      hash.merge!(
        warehouse: Warehouse.find(stock.warehouse_id).name,
        number: stock.document.number,
        date: stock.document.d_date.strftime("%Y-%m-%d"),
        stock_type: StockType.find(stock.document.stock_type_id).name,
        commodity:Commodity.find(stock.commodity_id).name
      )
      array << hash
    end
    return array
  end
  
  def self.download_xlsx(q)
    p = Axlsx::Package.new
    wb = p.workbook
    header = ['仓库', '单据编号', '业务日期', '单据类型', '商品编码', '商品名称', '规格型号', '单位', '库存变动']
    wb.add_worksheet(:name => "Sheet 1") do |sheet|
      sheet.add_row header, :types => [:string]
      q.each do |stock|
        arr = Array.new
        arr << Warehouse.find(stock.warehouse_id).name
        arr << stock.document.number
        arr << stock.document.d_date.strftime("%Y-%m-%d")
        arr << StockType.find(stock.document.stock_type_id).name
        arr << Commodity.find(stock.commodity_id).code
        arr << Commodity.find(stock.commodity_id).name
        arr << Commodity.find(stock.commodity_id).specification
        arr << Commodity.find(stock.commodity_id).unit
        arr << stock.quantity.abs
        sheet.add_row arr, :types => [:string]
      end
    end
    p.to_stream.read
  end
end
