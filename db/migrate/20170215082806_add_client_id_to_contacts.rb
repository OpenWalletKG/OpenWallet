class AddClientIdToContacts < ActiveRecord::Migration[5.0]
  def change
    add_reference :contacts, :client, foreign_key: true
  end
end
