class AddIndividualToClients < ActiveRecord::Migration[5.0]
  def change
    add_reference :clients, :individual, polymorphic: true
  end
end
