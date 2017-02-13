class AddClientIdToAccount < ActiveRecord::Migration[5.0]
  def change
    add_reference :accounts, :client, foreign_key: true
  end
end
