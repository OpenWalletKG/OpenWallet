class CorporateIndividual < ApplicationRecord
  belongs_to :corporate
  belongs_to :individual
  belongs_to :employee
end
