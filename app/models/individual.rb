class Individual < ApplicationRecord
  has_many :clients, as: :entity

  has_many :corporate_individuals
  has_many :corporates, through: :corporate_individuals

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :inn, presence: true,
            uniqueness: true
  validates :dob, presence: true


end
