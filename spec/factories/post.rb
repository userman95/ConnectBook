FactoryBot.define do

  factory :post do
    sequence(:content){ |n| "Content #{n}" }
    association :user
  end
end