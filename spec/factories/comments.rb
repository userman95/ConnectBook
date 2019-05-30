FactoryGirl.define do
  factory :comment do
    content "comment for @user post"
    post_id "1"
  end

    # user factory without associated posts
  factory :user do
    name "Orestis"
    email "o@g.c"
    password "123456"
    # user_with_posts will create post data after the user has been created
    factory :user_with_comments do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        comments_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end
  end
    # user factory without associated posts
  factory :post do
    name "John Doe"

    # user_with_posts will create post data after the user has been created
    factory :post_with_comments do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        comments_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end
  end
end
