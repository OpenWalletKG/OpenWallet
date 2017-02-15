class AddAddressIdToClient < ActiveRecord::Migration[5.0]
  def change
    add_reference :clients, :address, foreign_key: true
  end
end
