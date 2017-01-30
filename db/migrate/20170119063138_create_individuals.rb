class CreateIndividuals < ActiveRecord::Migration[5.0]
  def change
    create_table :individuals do |t|
      t.string :last_name
      t.string :first_name
      t.date :dob
      t.string :in

      t.timestamps
    end
  end
end
