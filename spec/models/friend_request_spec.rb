require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

  before do
    @user = User.create(name: "Orestis",email: "o@mail.com",password: "123456")
    @friend = User.create(name: 'Efrain',email: "e@mail.com",password: "123456")
    @post = @user.posts.create(content: "tests for post model")
    @friend_request = @user.friend_requests.create(friend: @friend)
  end

  context "associations tests" do

    it "a friend request should be destroyed after accepted" do
      @friend_request.accept
      expect { @friend_request.reload }.to raise_error ActiveRecord::RecordNotFound
    end

  end

  context "validations tests" do
    it "Inverse friendship should be valid after accept" do
      @friend_request.accept
      expect(@user.friends).to_not be_empty
      expect(@friend.friends).to_not be_empty
    end

    it "Shouldn't be able to send a second friend request to the same user" do
      @friend_request = @user.friend_requests.create(friend: @friend)
      expect(@friend_request).to_not be_valid
    end

    it "Shouldn't be able to send a friend request if users are friends" do
      @friend_request.accept
      @friend_request = @user.friend_requests.create(friend: @friend)
      expect(@friend_request).to_not be_valid
    end
  end

end
