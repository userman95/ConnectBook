require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){ build(:user, name: "Efrain", email: "e@mail.c") }
  let(:friend){ build(:user, name: "Orestis", email: "o@mail.c") }
  let(:requested_users){ create_list(:user, 10) }

  context 'validation tests' do

    it 'name should be present' do
      expect(user.name).not_to be_empty
    end

    it 'user should be valid' do
      expect(user.valid?).to eq(true)
    end

  end

  context 'association tests' do

    it 'user can send/receive a friend request to/from another' do
      user.save
      friend.save
      friend.friend_requests.create(friend: user)
      expect(friend.users_in_request.first).to eq(user)
      expect(user.users_in_request.first).to eq(friend)
    end

    it "a user can accept a friend request" do
      user.save
      friend.save
      user.friend_requests.create(friend: friend)
      friend.requests.first.accept
      expect(friend.reload.friends.first).to eq(user)
      expect(user.reload.friends.first).to eq(friend)
    end

    it "a user can decline a friend request" do
      user.save
      friend.save
      user.friend_requests.create(friend: friend)
      friend.reload.requests.first.decline
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
        requested_user.requests.first.accept
      end

      friend = requested_users.first

      expect(user.friends.size).to eq(10)
      expect(user.friends.first).to eq(friend)
      expect(friend.friends.first).to eq(user)
    end

  end
end
