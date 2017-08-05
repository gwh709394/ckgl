class CreateCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :code
      t.integer :commodity_type_id
      t.string :bar_code
      t.string :specification
      t.string :unit

      t.timestamps
    end
    add_index :commodities, :name
  end
end
