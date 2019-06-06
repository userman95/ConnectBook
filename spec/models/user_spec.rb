require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){ build(:user) }
  let(:friend){ build(:user, name: "Orestis", email: "o@mail.c", password: "123456") }

  context 'validation tests' do

    it 'name should be present' do
      expect( user.name).not_to be_empty
    end

    it 'user should be valid' do
      expect( user.valid?).to eq(true)
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

    # it "a user can accept a friend request" do
    #   user.save
    #   friend.save
    #   user.friend_requests.create(friend: friend)
    #   # I'm not sure here if I need to use active_friendships or
    #   # passive_frienship
    #   friend.active_friendships.create(friend: user)
    #   expect(friend.friends.first).to eq(user)
    # end

    # it "a user can decline a friend request" do
    #   user.save
    #   friend.save
    #   user.friend_requests.create(friend: friend)
    #   friend.requests.first.destroy
    #   expect (user.reload.requests.first).to be_nil
    # end

    # it "a user can check its pending requests" do
    # end

    # it "a user can check all its friends" do
    # end

  end
end
