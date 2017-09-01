class AddDeleteedAtToCommodity < ActiveRecord::Migration[5.0]
  def change
    add_column :commodities, :deleted_at, :datetime
    add_index :commodities, :deleted_at
  end
end
