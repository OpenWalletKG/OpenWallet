class Account < ApplicationRecord
  has_one :client
  has_one :bank_account, dependent: :destroy

  validates :number, presence: true, 
            uniqueness: true

  def self.encode( unique_identifier )
    Base58.encode( unique_identifier )
  end

  def self.add_account(current_client, account_params, type_account)
    client = BankHandler.new
    if client.add_account(current_client.entity.in, account_params[:number],current_client.entity_type)
      account_params[:client_id] = current_client.id
      account = new(account_params)
      account.save!
      account.build_bank_account(bank_id: type_account ).save!
    else
      false
    end
  end

end
