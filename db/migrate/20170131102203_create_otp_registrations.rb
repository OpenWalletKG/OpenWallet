class CreateOtpRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :otp_registrations do |t|
      t.references :draft_first_registration, foreign_key: true
      t.string :PIN
      t.integer :try_number
      t.boolean :succeeded

      t.timestamps
    end
  end
end
