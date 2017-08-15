class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :number
      t.integer :stock_type_id
      t.integer :warehouse_id
      t.datetime :d_date
      t.integer :staff_id
      t.text :summary

      t.timestamps
    end
    add_index :documents, :stock_type_id
    add_index :documents, :number
  end
end
