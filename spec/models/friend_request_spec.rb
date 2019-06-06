require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

  let(:user){ build(:user) }
  let(:friend){ build(:user, name: "Orestis", email: "o@mail.c", password: "123456") }
  let(:friend_request){ build(:friend_request)}

  context "associations tests" do
    it "a friend request should be destroyed after accepted" do
      friend_request.accept
      expect { friend_request.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context "validations tests" do
    let(:new_friend_request) { build(:friend_request) }

    it "Shouldn't be able to send a second friend request to the same user" do
      user.save
      friend.save
      friend_request.save
      expect(new_friend_request).to_not be_valid
    end

    it "Shouldn't be able to send a friend request if users are friends" do
      user.save
      user.added_friends << friend
      expect(new_friend_request.save).to_not be_valid
    end
  end

end
