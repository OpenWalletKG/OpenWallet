class Account < ApplicationRecord

  has_one :client

  
  validates :number, presence: true, 
            uniqueness: true

  def self.registration(unique_identifier)
    Account.create(number: unique_identifier + rand(10000..9999999).to_s)
  end

end
