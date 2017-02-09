class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.references :account, foreign_key: true
      t.references :bank, foreign_key: true
      t.string :bank_account_id

      t.timestamps
    end
  end
end
