class CreateDraftPhoneRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :draft_phone_registrations do |t|
      t.string :phone
      t.datetime :end_of_ban

      t.timestamps
    end
  end
end
