class AddLowHighStockToCommodities < ActiveRecord::Migration[5.0]
  def change
    add_column :commodities, :low_stock, :integer
    add_column :commodities, :high_stock, :integer
    add_index :commodities, :low_stock
    add_index :commodities, :high_stock
  end
end
