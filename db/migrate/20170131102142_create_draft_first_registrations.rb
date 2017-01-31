class CreateDraftFirstRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :draft_first_registrations do |t|
      t.string :phone
      t.date :end_of_ban

      t.timestamps
    end
  end
end
