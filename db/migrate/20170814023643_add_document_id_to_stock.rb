class AddDocumentIdToStock < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :document_id, :integer
    add_index :stocks, :document_id
  end
end
