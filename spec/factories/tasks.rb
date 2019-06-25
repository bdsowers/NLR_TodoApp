FactoryBot.define do
  factory :task do
    association :user
    name { "MyString" }
    priority { 1 }
    due_date { DateTime.now }
  end

  factory :homework, class: Task do
    association :user
  	name { "Do your homework" }
  	priority { 1 }
    due_date { DateTime.now }
  end

  factory :invalid_task, class: Task do
    association :user
  	name { nil }
  	priority { nil }
    due_date { nil }
  end
end
