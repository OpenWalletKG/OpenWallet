class CreateCorporates < ActiveRecord::Migration[5.0]
  def change
    create_table :corporates do |t|
      t.string :registration_number
      t.string :in
      t.string :address

      t.timestamps
    end
  end
end
