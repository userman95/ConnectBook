FactoryBot.define do

  factory :user do
    name { "Efrain" }
    email { "e@mail.c" }
    password { "123456" }
  end

  factory :friend_request do
    user
    association :friend, factory: :user
  end
end
