class AddOperationToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_reference :documents, :operation, foreign_key: true
  end
end
