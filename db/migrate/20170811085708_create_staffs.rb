class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :number
      t.integer :gender, default: 1
      t.string :telephone
      t.string :address
      t.integer :status, default: 1

      t.timestamps
    end
    add_index :staffs, :name
  end
end
