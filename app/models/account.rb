class Account < ApplicationRecord

  has_one :client

  
  validates :number, presence: true, 
            uniqueness: true


end
