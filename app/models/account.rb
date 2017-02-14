class Account < ApplicationRecord

  has_one :client
  has_one :bank_account, dependent: :destroy
  
  validates :number, presence: true, 
            uniqueness: true

  def self.encode( unique_identifier )
    Base58.encode( unique_identifier )
  end

end
