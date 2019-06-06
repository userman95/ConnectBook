FactoryBot.define do

  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@mail.c" }
    password { "123456" }
  end

  factory :friend_request do
    user
    association :friend, factory: :user
  end
end
