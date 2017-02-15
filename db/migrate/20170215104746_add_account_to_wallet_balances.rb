class AddAccountToWalletBalances < ActiveRecord::Migration[5.0]
  def change
    add_reference :wallet_balances, :account, foreign_key: true
  end
end
