require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.create(name: "Orestis",email: "o@mail.com",password: "123456")
    @friend = User.create(name: 'Efrain',email: "e@mail.com",password: "123456")
    @post = @user.posts.create(content: "tests for post model")
    @friend_request = @user.friend_requests.create(friend: @friend)
  end

  context 'validation tests' do

    it 'user should be valid' do
      expect( @user.valid?).to eq(true)
    end

    it 'name should be present' do
      expect( @user.name).not_to be_empty
    end

    it 'email should be present' do
      expect( @user.email).not_to be_empty
    end

    it 'password should be present' do
      expect( @user.password).not_to be_empty
    end

    it 'password length should at least 6 characters' do
      expect( @user.password.length).to be >= 6
    end
  end

  context 'association tests' do

    it 'user can send a friend request to another' do
      @friend.friend_requests.create(friend: @user)
      expect(@friend.friend_requests.first.friend_id).to eq(@user.id)
    end

    it 'a user can receive a friend request' do
      @friend.friend_requests.create(friend: @user)
      expect(@friend.friend_requests.size).to eq 1
    end

    it "a user can accept a friend request" do
      @friend_request.accept
      expect(@user.friends).to_not be_empty
    end

    it "a user can decline a friend request" do
      @friend_request.decline
      expect { @friend_request.reload }.to raise_error ActiveRecord::RecordNotFound
    end

  end
end
