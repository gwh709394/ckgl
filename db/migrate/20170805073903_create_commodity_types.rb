class CreateCommodityTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :commodity_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :commodity_types, :name
  end
end
