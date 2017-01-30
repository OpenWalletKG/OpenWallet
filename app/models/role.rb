class Role < ApplicationRecord
  has_many :clients
  has_many :roles_actions
  has_many :actions, through: :roles_actions

  validates :definition, presence: true, 
            uniqueness: true

end
