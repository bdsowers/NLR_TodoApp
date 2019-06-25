require 'rails_helper'

RSpec.describe User, type: :model do

  let(:test_user) { build(:user) }

  it "is valid with the appropriate attributes" do
  	expect(test_user).to be_valid
  end

  it "is invalid without a firstname" do
  	test_user.firstname = nil
  	expect(test_user).not_to be_valid
  end

  it "is invalid without a lastname" do
  	test_user.lastname = nil
  	expect(test_user).not_to be_valid
  end

  it "is invalid without an email" do
  	test_user.email = nil
  	expect(test_user).not_to be_valid
  end

  it "has two tasks" do
  	expect(test_user.tasks.length).to eq(2)
  end
end
