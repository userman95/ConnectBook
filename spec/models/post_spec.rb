require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user = User.create(name: 'Orestis', email: 'o@g.c', password: '123456')
    @post = @user.posts.create(content: "tests for post model")
  end

  context "validations tests" do
    it "post should be valid" do
      expect(@post).to be_valid
    end

    it "post should be present" do
      @post.content = ' '
      expect(@post).to_not be_valid
    end
  end

  context "associations tests" do
    it "post should belong to a user" do
      expect(@post.user).to_not be_nil
    end

    it "post content shouldn't be longer than 140 characters" do
      @post.content = 'a' * 141
      expect(@post).to_not be_valid
    end

    it "all posts of the user should be destroyed when a user is destroyed" do
      @user.destroy
      expect(@user.posts).to be_empty
    end
  end

end
