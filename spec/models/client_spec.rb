require 'rails_helper'

RSpec.describe Client, :type => :model do
  role = Role.create(id: 1, definition: 'Person')
  individual = Individual.create(id: 1, first_name: 'Vasya', last_name: "T", inn: '1234566', dob: Time.now)
  account = Account.create(id: 1, number: '0557140446')
  p individual
  subject {
    described_class.create(mobile: '0556120732', country: 'Kyrgyzstan', account_id: account.id,
    role_id: role.id, entity_type: "Individual", entity_id: individual.id, email: 'client@example.com'
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
    subject.entity_type = nil
    expect(subject).to_not be_valid
  end
  # it "is invalid with a duplicate description" do
  #   Action.create(description: 'какое-то другое действие')
  #   action = Action.new(description: 'какое-то другое действие')
  #   action.valid?
  #   expect(action.errors[:description]).to include("has already been taken")
  # end
  #
  # it { should have_many(:roles_actions) }
  # it { should have_many(:roles) }
end
