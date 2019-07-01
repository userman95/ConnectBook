require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

  # let(:user){ create(:user_with_requests, how_many_requests: 2) }
  let(:user){ create(:user) }
  let(:friend){ create(:user) }
  let(:friend_request){ create(:friend_request, user: user, friend: friend) }

  describe "validations" do
    let(:new_friend_request) { build(:friend_request, user: user, friend: friend) }
    let(:invert_friend_request){ build(:friend_request, user: friend, friend: user) }
    let(:itself_friend_request){ build(:friend_request, user: user, friend: user) }
    let(:friendship){ create(:friendship, user: user, friend: friend) }

    context "attributes" do
      it "user should be present" do
        expect(new_friend_request.user).to be_present
      end

      it "friend should be present" do
        expect(new_friend_request.friend).to be_present
      end
    end

    context "methods" do
      it "shouldn't be able to send a second friend request to the same user" do
        friend_request
        user.reload
        friend.reload
        expect(new_friend_request).to_not be_valid
      end

      it "shouldn't be able to send a friend request if it already received one" do
        friend_request
        user.reload
        friend.reload
        expect(invert_friend_request).to_not be_valid
      end

      it "shouldn't be able to send a friend request to itself" do
        expect(itself_friend_request).to_not be_valid
      end

      it "shouldn't be able to send a friend request if users are friends" do
        friend_request.save
        friendship
        user.reload
        friend.reload
        expect(new_friend_request).to_not be_valid
      end
    end
  end
end
