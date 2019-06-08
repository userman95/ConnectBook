require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user){ create(:user_with_posts, name: "Orestis") }
  let(:friend){ create(:user_with_posts, name: "Efrain") }
  let(:comment){ build(:comment, user: friend, post: user.posts.last) }

  context "validation tests" do
    it "comment should be valid" do
      expect(comment).to be_valid
    end

    it "comment content shouldn't be empty" do
      comment.content = " "
      expect(comment).to_not be_valid
    end

    it "comment content shouldn't be longer than 140 characters" do
      comment.content = 'a' * 141
      expect(comment).to_not be_valid
    end
  end

  context "association tests" do
    it "a comment should belong to a post" do
      expect(comment.post).to eq(user.posts.last)
      expect(comment.post).to_not eq(user.posts.first)
    end

    it "a comment should belong to a user" do
      expect(comment.user).to eq(friend)
    end

    it "a comment should be deleted when it's user is destroyed" do
      friend.destroy
      expect(Comment.find_by(id: comment.id)).to be_nil
    end

    it "a comment should be deleted when it's post is destroyed" do
      user.posts.last.destroy
      expect(Comment.find_by(id: comment.id)).to be_nil
    end
  end

end
