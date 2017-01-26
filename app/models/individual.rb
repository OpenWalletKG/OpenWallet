class Individual < ApplicationRecord
  has_many :clients, as: :entity

  has_many :corporate_individuals
  has_many :corporates, through: :corporate_individuals

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :inn, presence: true,
            uniqueness: true
  validates :dob, presence: true


  def self.registration(individual_params)
    individual_params = individual_params.permit(:first_name, :last_name, :inn, :dob)
    Individual.create(individual_params)
  end

  def self.registration_employee

  end

end
