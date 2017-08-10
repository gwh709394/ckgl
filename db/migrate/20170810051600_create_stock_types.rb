class CreateStockTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_types do |t|
      t.string :name
      t.integer :s_type

      t.timestamps
    end
  end
end
