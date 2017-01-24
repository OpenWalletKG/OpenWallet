require 'rails_helper'

RSpec.describe Account, :type => :model do
  subject {
    described_class.new(number: "0556120732")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a number" do
    subject.number = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with a duplicate number" do
    Account.create(number: '0556120732')
    account = Account.new(number: '0556120732')
    account.valid?
    expect(account.errors[:number]).to include("has already been taken")
  end

  it { should have_one(:client) }

end
