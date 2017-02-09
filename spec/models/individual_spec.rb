require 'rails_helper'

RSpec.describe Individual, :type => :model do

  subject {
    described_class.create(first_name: 'Azamat', last_name: 'Djumabekov', in: '987234985723',
                           dob: Date.today
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an inn" do
    subject.in = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a dob" do
    subject.dob = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate inn" do
    Individual.create(first_name: 'Azamat', last_name: 'Djumabekov', in: '987234985723',
                      dob: Date.today
    )
    new_inn = Individual.create(first_name: 'Dmitrii', last_name: 'Zagvoskin', in: '987234985723',
                                dob: Date.today
    )
    new_inn.valid?
    expect(new_inn.errors[:in]).to include("has already been taken")
  end

  it { should have_one(:client) }
  it { should have_many(:corporate_individuals) }
  it { should have_many(:corporates) }

end