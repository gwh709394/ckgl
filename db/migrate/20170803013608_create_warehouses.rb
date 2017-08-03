class CreateWarehouses < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :code
      t.string :location
      t.string :remark

      t.timestamps
    end
    add_index :warehouses, :name
  end
end
