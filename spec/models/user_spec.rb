require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){ build(:user, name: "Efrain", email: "e@mail.c") }
  let(:friend){ build(:user, name: "Orestis", email: "o@mail.c") }
  let(:requested_users){ create_list(:user, 10) }

  describe "validations" do
    context "right attributes" do

      it 'name should be present' do
        expect(user.name).not_to be_empty
      end

      it 'user should be valid' do
        expect(user).to be_valid
      end
    end

    context "empty name" do

      it "is invalid" do
        user.name = " "
        expect(user).to be_invalid
      end
    end
  end

  describe "association" do

    it 'user can send/receive a friend request to/from another' do
      user.save
      friend.save
      friend.friend_requests.create(friend: user)
      user.reload
      expect(friend.users_in_request.first).to eq(user)
      expect(user.users_in_request.first).to eq(friend)
    end

    it "a user can accept a friend request" do
      user.save
      friend.save
      user.friend_requests.create(friend: friend)
      friend.added_by_friends << user
      friend.requests.first.destroy
      expect(FriendRequest.find_by(id: friend.requests.first.id)).to be_nil
      expect(friend.reload.friends.first).to eq(user)
      expect(user.reload.friends.first).to eq(friend)
    end

    it "a user can decline a friend request" do
      user.save
      friend.save
      user.friend_requests.create(friend: friend)
      friend.reload.requests.first.destroy

      expect(friend.reload.requests).to be_empty
      expect(user.reload.requests).to be_empty
    end

    it "a user can check its pending requests" do
      user.save

      requested_users.each do |requested_user|
        user.friend_requests.create(friend: requested_user)
      end

      future_friend = requested_users.first
      expect(user.requests.size).to eq(10)
      expect(future_friend.reload.users_in_request.first).to eq(user)
      expect(user.reload.users_in_request.first).to eq(future_friend)
    end

    it "a user can check all its friends" do
      user.save

      requested_users.each do |requested_user|
        user.friend_requests.create(friend: requested_user)
        requested_user.added_by_friends << user
        requested_user.requests.first.destroy
      end

      friend = requested_users.first

      expect(user.reload.friends.size).to eq(10)
      expect(user.requests.count).to eq(0)
      expect(user.friends.first).to eq(friend)
      expect(friend.friends.first).to eq(user)
    end

  end
end
