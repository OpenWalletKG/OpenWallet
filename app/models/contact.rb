class Contact < ApplicationRecord
  belongs_to :client
  validates :value, presence: true
end
