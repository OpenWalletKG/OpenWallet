class BankAccount < ApplicationRecord
  belongs_to :account
  belongs_to :bank

   ADAPTERS = {
       'Tengri' => EsbClient
   }

  def self.add_account(account_id, account_params, client_params)
    begin
      plugin = get_bank_name(account_params[:bank_id])
      bank_account_id = ADAPTERS[plugin].add_account(account_params, client_params)
      new_account = new(account_id: account_id, bank_id: account_params[:bank_id], bank_account_id: bank_account_id)
      new_account.save!
    rescue ESBError => e
      raise Exception.new('Что-т пошло не так')
      false
    end
  end

  def self.get_bank_name(bank_id)
    Bank.find(bank_id)[:name]
  end
end