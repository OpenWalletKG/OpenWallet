require 'rails_helper'

RSpec.describe Corporate, :type => :model do

  subject { described_class.create(registration_number: '129898324697268', in: '7689987356')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a registration_number" do
    subject.registration_number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a bin" do
    subject.in = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate registration_number" do
    Corporate.create(registration_number: '1119922', in: '007689356')
    new_registration_number = Corporate.create(registration_number: '1119922', in: '79869827364542')
    new_registration_number.valid?
    expect(new_registration_number.errors[:registration_number]).to include("has already been taken")
  end

  it "is invalid with a duplicate bin" do
    Corporate.create(registration_number: '339922', in: '7689356')
    new_bin = Corporate.create(registration_number: '1119922', in: '7689356')
    new_bin.valid?
    expect(new_bin.errors[:in]).to include("has already been taken")
  end

  it { should have_one(:client) }
  it { should have_many(:corporate_individuals) }
  it { should have_many(:employees) }
  it { should have_many(:individuals) }

end