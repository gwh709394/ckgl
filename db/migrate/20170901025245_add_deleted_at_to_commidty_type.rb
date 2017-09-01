class AddDeletedAtToCommidtyType < ActiveRecord::Migration[5.0]
  def change
    add_column :commodity_types, :deleted_at, :datetime
    add_index :commodity_types, :deleted_at
  end
end
