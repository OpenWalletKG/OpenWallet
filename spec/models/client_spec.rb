require 'rails_helper'

RSpec.describe Client, :type => :model do

  role = Role.create(definition: 'Person')
  individual = Individual.create(first_name: 'Vasya', last_name: 'Tor', in: '121212', dob: Time.now)
  account = Account.create(number: '0557140446')

  subject {
    described_class.create(mobile: '0556120732', country: 'Kyrgyzstan', account_id: role.id,
                           role_id: account.id, entity_type: individual.class.name, entity_id: individual.id,
                           email: 'client@example.com', password: '123456', password_confirmation: '123456'
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a mobile" do
    subject.mobile = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a country" do
    subject.country = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an account_id" do
    subject.account_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a role_id" do
    subject.role_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an entity_type" do
    subject.entity_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an entity_id" do
    subject.entity_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password_confirmation" do
    subject.password_confirmation = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate mobile" do
    Client.create(mobile: '0556120732', country: 'Kazakstan', account_id: role.id,
                  role_id: account.id, entity_type: individual.class.name, entity_id: individual.id,
                  email: 'client@example.com', password: '123456', password_confirmation: '123456'
    )
    new_mobile = Client.create(mobile: '0556120732', country: 'Kyrgyzstan', account_id: role.id,
                               role_id: account.id, entity_type: individual.class.name,
                               entity_id: individual.id,
                               email: 'client@example.com', password: '123456',
                               password_confirmation: '123456'
    )
    new_mobile.valid?
    expect(new_mobile.errors[:mobile]).to include("has already been taken")
  end

  wrong_number = 'jhbasf8987323kjfyjydtjyrdjy'

  it { should allow_value("0554123456").for(:mobile) }
  it { should_not allow_value(wrong_number.to_s).for(:mobile) }

  it { should belong_to(:account) }
  it { should belong_to(:role) }
  it { should belong_to(:entity) }

end