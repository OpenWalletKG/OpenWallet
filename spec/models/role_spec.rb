require 'rails_helper'

RSpec.describe Role, :type => :model do

  subject {
    described_class.create(definition: 'Физическое лицо')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a definition" do
    subject.definition = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate definition" do
    Role.create(definition: 'Агент1')
    new_role = Role.create(definition: 'Агент1')
    new_role.valid?
    expect(new_role.errors[:definition]).to include("has already been taken")
  end

  it { should have_many(:clients) }
  it { should have_many(:roles_actions) }
  it { should have_many(:actions) }

end