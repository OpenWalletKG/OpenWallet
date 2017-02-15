class AddOperationRefToCorrespondentAccounts < ActiveRecord::Migration[5.0]
  def change
    add_reference :correspondent_accounts, :operation, foreign_key: true
  end
end
