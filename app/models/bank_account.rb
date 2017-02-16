class BankAccount < ApplicationRecord
  belongs_to :account
  belongs_to :bank

  def self.add_account(bank_id, account_id, iban, inn, client_type)
    adapter = BankAdapter.new
    bank_account_id = adapter.add_account(inn, iban, client_type)
    unless bank_account_id == false
      new_account = new(account_id:account_id, bank_id:bank_id, bank_account_id: bank_account_id)
      new_account.save!
    else
      false
    end
  end
end