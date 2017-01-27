require 'rails_helper'

RSpec.describe Corporate, :type => :model do

  subject { described_class.create(registration_number: '129898324697268', bin: '7689987356',
                                   address: 'ул. Орловская, д. 14, кв. 12'
            )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a registration_number" do
    subject.registration_number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a bin" do
    subject.bin = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an address" do
    subject.address = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate registration_number" do
    Corporate.create(registration_number: '1119922', bin: '007689356',
                     address: 'ул. Орловская, д. 14, кв. 12')
    new_registration_number = Corporate.create(registration_number: '1119922', bin: '79869827364542',
                                               address: 'ул. Набережная, д. 29, кв. 23')
    new_registration_number.valid?
    expect(new_registration_number.errors[:registration_number]).to include("has already been taken")
  end

  it "is invalid with a duplicate bin" do
    Corporate.create(registration_number: '339922', bin: '7689356',
                     address: 'ул. Орловская, д. 14, кв. 12')
    new_bin = Corporate.create(registration_number: '1119922', bin: '7689356',
                                               address: 'ул. Кривоносова, д. 21, кв. 33')
    new_bin.valid?
    expect(new_bin.errors[:bin]).to include("has already been taken")
  end

  it { should have_many(:clients) }
  it { should have_many(:corporate_individuals) }
  it { should have_many(:employees) }
  it { should have_many(:individuals) }

end