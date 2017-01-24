require 'rails_helper'

RSpec.describe Action, :type => :model do
  subject {
    described_class.new(description: "какое-то действие")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate description" do
    Action.create(description: 'какое-то другое действие')
    action = Action.new(description: 'какое-то другое действие')
    action.valid?
    expect(action.errors[:description]).to include("has already been taken")
  end

  it { should have_many(:roles_actions) }
  it { should have_many(:roles) }
end
