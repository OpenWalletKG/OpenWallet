class CreateWalletBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :wallet_balances do |t|
      t.decimal :balance

      t.timestamps
    end
  end
end
