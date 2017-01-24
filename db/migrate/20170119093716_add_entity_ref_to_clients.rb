class AddEntityRefToClients < ActiveRecord::Migration[5.0]
  def change
    add_reference :clients, :entity, polymorphic: true
  end
end
