FactoryBot.define do

  factory :comment do
    sequence(content){ |n| "Comment #{n} for post" }
    user
    post
  end
end