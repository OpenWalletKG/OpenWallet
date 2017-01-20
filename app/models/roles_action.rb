class RolesAction < ApplicationRecord
  belongs_to :role
  belongs_to :action

  validates_uniqueness_of :role_id, scope: [:action_id] 
end
