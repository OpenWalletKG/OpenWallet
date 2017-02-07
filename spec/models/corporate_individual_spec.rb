require 'rails_helper'

RSpec.describe CorporateIndividual, :type => :model do

  corporate = Corporate.create(registration_number: '98324697268', in: '7689356')
  employee = Employee.create(position: 'Директор')
  individual = Individual.create(first_name: 'Omurbek', last_name: 'Choibekov', in: '121212', dob: Time.now)

  subject { described_class.create(corporate_id: corporate.id, employee_id: employee.id,
                                   individual_id: individual.id
            )
  }

  it { should belong_to(:corporate) }
  it { should belong_to(:individual) }
  it { should belong_to(:employee) }

end