FactoryBot.define do

  factory :friendship do
    user
    association :friend, factory: :user
  end
end