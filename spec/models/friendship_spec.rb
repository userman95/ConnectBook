require 'rails_helper'

RSpec.describe Friendship, type: :model do

  before do
    @user = User.create(name: "Orestis",email: "o@mail.com",password: "123456")
    @friend = User.create(name: 'Efrain',email: "e@mail.com",password: "123456")
    @post = @user.posts.create(content: "tests for post model")
    @comment = @user.comments.create(content: "comment for @user post", post_id: @post.id)
  end

  context "associations tests" do
    it "a user can be friends with another user" do
      @user.friends << @friend
      expect(@friend.friends).to_not be_empty
      expect(@user.friends).to_not be_empty
    end

    it "a friendship should be destroyed when a user deletes another" do
      @user.friends << @friend
      expect(@user.friends).to_not be_empty
      @user.delete_friend(@friend)
      expect(@user.friends).to be_empty
      expect(@friend.friends).to be_empty
    end
  end

  context "validations tests" do
    it "Inverse friendship should be valid" do
      @user.friends << @friend
      expect(@friend.friends.first).to be_valid
    end
  end

end
