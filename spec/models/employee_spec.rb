require 'rails_helper'

RSpec.describe Employee, :type => :model do
  subject {
    described_class.new(position: "Бухгалтер")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a position" do
    subject.position = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate position" do
    Employee.create(position: 'Директор')
    new_employee = Employee.new(position: 'Директор')
    new_employee.valid?
    expect(new_employee.errors[:position]).to include("has already been taken")
  end

  it { should have_many(:corporate_individuals) }
  it { should have_many(:corporates) }

end
