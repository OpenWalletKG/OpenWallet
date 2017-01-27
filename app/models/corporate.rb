class Corporate < ApplicationRecord
  has_many :clients, as: :entity

  has_many :corporate_individuals

  has_many :employees, through: :corporate_individuals
  has_many :individuals, through: :corporate_individuals

  validates :registration_number, presence: true,
            uniqueness: true

  validates :bin, presence: true, 
            uniqueness: true

  validates :address, presence: true
end
