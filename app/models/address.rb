class Address < ApplicationRecord
  has_one :client
  validates :country, presence: true
end
