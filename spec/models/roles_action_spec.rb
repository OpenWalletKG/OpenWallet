require 'rails_helper'

RSpec.describe RolesAction, :type => :model do

  role = Role.create(definition: 'Агент обычный')
  action = Action.create(description: 'Ввод денег на СЭД агента')

  subject {
    described_class.create(role_id: role.id, action_id: action.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a role_id" do
    subject.role_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an action_id" do
    subject.action_id = nil
    expect(subject).to_not be_valid
  end

  it { should validate_uniqueness_of(:role_id).scoped_to(:action_id) }

  it { should belong_to(:role) }
  it { should belong_to(:action) }

end