require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user){ create(:user, name: "Efrain", email: "e@mail.c") }
  let(:post){ build(:post, content: "First post", user: user) }

  context "validation tests" do
    it "post should be valid" do
      expect(post).to be_valid
    end

    it "post should be present" do
      post.content = ' '
      expect(post).to_not be_valid
    end

    it "post content shouldn't be longer than 140 characters" do
      post.content = 'a' * 141
      expect(post).to_not be_valid
    end
  end

  context "association tests" do
    let(:friends_for_likes){ create_list(:user, 10) }
    let(:friends_for_comments){ create_list(:user, 5) }

    it "post should belong to a user" do
      expect(post.user).to eq(user)
    end

    it "all posts of the user should be destroyed when a user is destroyed" do
      user.destroy
      expect(user.posts).to be_empty
      expect(Post.find_by(id: post.id)).to be_nil
    end

    it "post receives 10 likes" do
      post.save
      
      expect{ 
        friends_for_likes.each do |friend|
          post.likes.create(user: friend)
        end
      }.to change{ post.likes.count }.from(0).to(10)
    end

    it "post receives 5 comments" do
      post.save
      
      expect{ 
        friends_for_comments.each do |friend|
          post.comments.create(user: friend, content: "a comment")
        end
      }.to change{ post.comments.count }.from(0).to(5)
    end
  end

end
