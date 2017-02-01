class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
  def up
    add_column :clients, :confirmation_token, :string
    add_column :clients, :confirmed_at, :datetime
    add_column :clients, :confirmation_sent_at, :datetime
    add_index :clients, :confirmation_token, unique: true
    execute("UPDATE clients SET confirmed_at = NOW()")
  end

  def down
    remove_columns :clients, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
