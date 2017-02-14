class CorporateIndividual < ApplicationRecord
  belongs_to :corporate
  belongs_to :individual
  belongs_to :employee

  def self.register_head( head )
    head_employee = Employee.get_employee( head[:position] )
    corporate_head = Individual.where(in: head[:in]).first
    corporate_head ||= Individual.create( head.except(:position, :corporate_id) )
    CorporateIndividual.create(corporate_id: head[:corporate_id], individual: corporate_head, employee: head_employee )
  end

  def self.is_employee?( individual_in )
    individual = Individual.find_by_in( individual_in )
    return false if individual.nil?
    !!find_by( individual_id: individual.id )
  end

end
