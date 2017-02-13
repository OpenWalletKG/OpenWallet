class Employee < ApplicationRecord
  has_many :corporate_individuals
  has_many :corporates, through: :corporate_individuals
  validates :position, presence: true,
            uniqueness: true

  POSITIONS = {
      default: 1
  }

  def self.get_employee( position )
    return find(POSITIONS[:default]) if position.nil?
    find_or_create_by( position )
  end
end
