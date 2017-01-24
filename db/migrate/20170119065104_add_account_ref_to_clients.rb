class AddAccountRefToClients < ActiveRecord::Migration[5.0]
  def change
    add_reference :clients, :account, foreign_key: true
  end
end
