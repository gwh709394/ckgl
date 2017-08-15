class AddCostSaleToCommmodity < ActiveRecord::Migration[5.0]
  def change
    add_column :commodities, :cost, :decimal, :precision => 8, :scale => 2
    add_column :commodities, :sale, :decimal, :precision => 8, :scale => 2
  end
end
