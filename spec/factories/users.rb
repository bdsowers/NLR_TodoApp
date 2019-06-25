FactoryBot.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    email { FFaker::Internet.email }

    after(:build) do |user|
    	user.tasks << FactoryBot.build(:homework, user: user)
    	user.tasks << FactoryBot.build(:homework, user: user)
    end
  end
end
