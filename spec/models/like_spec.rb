require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user){ create(:user_with_posts, name: "Orestis") }
  let(:friend){ create(:user_with_posts, name: "Efrain") }
  let(:like){ build(:like, user: friend, post: user.posts.last) }

  context "validation tests" do

    it "like should be valid" do
      expect(like).to be_valid
    end
  end

  context "association tests" do
    
    it "user is present" do
      expect(like.user).to be_present
    end

    it "post is present" do
      expect(like.post).to be_present
    end

    it "like should be deleted when its user is destroyed" do
      user.destroy
      expect(Like.find_by(id: like.id)).to be_nil
    end

    it "like should be deleted when its post is destroyed" do
      user.posts.first.destroy
      expect(Like.find_by(id: like.id)).to be_nil
    end
  end

end
