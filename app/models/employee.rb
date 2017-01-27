class Employee < ApplicationRecord
  has_many :corporate_individuals
  has_many :corporates, through: :corporate_individuals
  validates :position, presence: true,
            uniqueness: true
end
