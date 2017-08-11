class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :code
      t.integer :commodity_id
      t.integer :stock_type_id
      t.integer :warehouse_id
      t.decimal :price, :precision => 8, :scale => 2, default: 0.00
      t.integer :quantity
      t.decimal :sum, :precision => 8, :scale => 2, default: 0.00
      t.text :summary
      t.datetime :s_date

      t.timestamps
    end
  end
end
