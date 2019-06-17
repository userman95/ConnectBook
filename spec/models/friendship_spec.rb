require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:user){ create(:user, name: "Orestis",email: "o@mail.com") }
  let(:friend){ create(:user, name: "Efrain",email: "e@mail.com") }
  let(:friend_request){ create(:friend_request, user: user, friend: friend) }
  let(:friendship){ build(:friendship, user: friend, friend: user) }

  describe "validations" do
    let(:inverse_friendship){ build(:friendship, user: friend, friend: user) }
    let(:itself_friendship){ build(:friendship, user: friend, friend: friend) }

    it "user should be present" do
      expect(friendship.user).to be_present
    end

    it "friend should be present" do
      expect(friendship.friend).to be_present
    end
    
    it "inverse friendship shouldn't be valid" do
      friend_request
      friendship.save
      user.reload
      friend.reload
      expect(inverse_friendship).to_not be_valid
    end

    it "user shoudn't be able to create a friendship with itself" do
      expect(itself_friendship).to_not be_valid
    end
  end

  describe "associations" do
    it "a user can be friends with another user" do
      friend_request
      friendship.save
      user.reload
      friend.reload
      expect(friend.friends.first).to eq(user)
      expect(user.friends.first).to eq(friend)
    end

    it "a friendship should be destroyed when requester is deleted" do
      friendship
      user.destroy
      expect(Friendship.find_by(id: friendship.id)).to be_nil
    end

    it "a friendship should be destroyed when receiver is deleted" do
      friendship
      friend.destroy
      expect(Friendship.find_by(id: friendship.id)).to be_nil
    end
  end

end
