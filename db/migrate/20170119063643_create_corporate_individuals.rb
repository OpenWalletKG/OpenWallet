class CreateCorporateIndividuals < ActiveRecord::Migration[5.0]
  def change
    create_table :corporate_individuals do |t|
      t.references :corporate, foreign_key: true
      t.references :individual, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
