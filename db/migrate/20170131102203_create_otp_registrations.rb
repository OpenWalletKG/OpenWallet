class CreateOtpRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :otp_registrations do |t|
      t.references :draft_phone_registration, foreign_key: true
      t.string :pin
      t.integer :try_count
      t.boolean :succeeded

      t.timestamps
    end
  end
end
