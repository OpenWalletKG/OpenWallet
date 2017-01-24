class AddRoleRefToClients < ActiveRecord::Migration[5.0]
  def change
    add_reference :clients, :role, foreign_key: true
  end
end
