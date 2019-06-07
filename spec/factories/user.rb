FactoryBot.define do

  factory :user, aliases: [:friend] do
    transient do
      how_many_requests { 5 }
    end

    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@mail.c" }
    password { "123456" }

    factory :user_with_requests do
      after(:create) do |user, evaluator|
        evaluator.how_many_requests.times do
          # user.pending_friends << FactoryBot.create(:friend)
          user.friend_requests.create(friend: FactoryBot.create(:friend))
        end
      end
    end
  end
end
