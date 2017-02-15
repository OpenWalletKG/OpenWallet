class CreateCorrespondentAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :correspondent_accounts do |t|
      t.decimal :balance

      t.timestamps
    end
  end
end
