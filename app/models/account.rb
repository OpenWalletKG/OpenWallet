class Account < ApplicationRecord
  has_one :client
  has_one :bank_account, dependent: :destroy

  validates :number, presence: true, 
            uniqueness: true

  def self.encode( unique_identifier )
    Base58.encode( unique_identifier )
  end

  def self.add_bank_account(current_client, account_params, bank_id)
    account = new(account_params)
    account.client_id = current_client.id
    account.save
    if BankAccount.add_account(bank_id, account.id, account_params[:number], current_client.entity.in, current_client.entity_type)
      account.save
    else
      account.destroy
      false
    end
  end
end
