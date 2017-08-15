class CreateCommodityWarehouseRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :commodity_warehouse_relationships do |t|
      t.integer :commodity_id
      t.integer :warehouse_id
      t.integer :stock_quantity
      t.timestamps
    end
    add_index :commodity_warehouse_relationships, :commodity_id
    add_index :commodity_warehouse_relationships, :warehouse_id
  end
end
