class Role < ApplicationRecord
  has_many :clients
  has_many :roles_actions
  has_many :actions, through: :roles_actions

  validates :definition, presence: true, 
            uniqueness: true

  AGENT_0     = 1
  AGENT       = 2
  INDIVIDUAL  = 3
  SUPPLIER    = 4

  scope :get_agent_0,   -> { where(id: AGENT_0).first }
  scope :get_agent,     -> { where(id: AGENT).first }
  scope :get_individual,-> { where(id: INDIVIDUAL).first }
  scope :get_supplier,  -> { where(id: SUPPLIER).first }
end
