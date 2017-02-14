class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :agent_id
      t.string :client_id
      t.string :account_id
      t.decimal :sum
      t.string :target
      t.string :status, default: "new"
      t.string :doc_type

      t.timestamps
    end
  end
end
