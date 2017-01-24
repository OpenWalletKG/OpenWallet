class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :mobile
      t.string :country


      t.timestamps
    end
  end
end
