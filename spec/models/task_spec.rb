require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a name and a priority" do
  	task = build(:homework)
  	expect(task).to be_valid
  end

  it "is invalid without a name" do
  	task = build(:homework, name: nil)
  	expect(task).not_to be_valid
  end

  it "is invalid without a priority" do
  	task = build(:homework, priority: nil)
  	expect(task).not_to be_valid
  end

  it 'belongs to User' do
  	expect(Task.reflect_on_association(:user).macro).to eq(:belongs_to)
  end
end
