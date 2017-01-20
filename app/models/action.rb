class Action < ApplicationRecord
  has_many :roles_actions
  has_many :roles, through: :roles_actions

  validates :description, presence: true,
           uniqueness: true
end
