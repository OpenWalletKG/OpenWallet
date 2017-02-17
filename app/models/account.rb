class Account < ApplicationRecord
  has_one :client
  has_one :bank_account, dependent: :destroy

  validates :number, presence: true, 
            uniqueness: true

  def self.encode( unique_identifier )
    Base58.encode( unique_identifier )
  end

  def self.add_bank_account(current_client, account_params, bank_id)
    bank_account_params = {
        bank_id: bank_id,
        iban: account_params[:number]
    }

    client_params = {
        inn: current_client.entity.in,
        client_type: current_client.entity_type
    }



    begin
    account = new(account_params)
    account.client_id = current_client.id
    account.save
    BankAccount.add_account(account.id, bank_account_params, client_params)
    rescue  Exception =>  e
      account.destroy
      false
    end
  end
end
