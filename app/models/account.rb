class Account < ApplicationRecord

  
  validates :number, presence: true, 
            uniqueness: true
end
