require 'rails_helper'

RSpec.describe Comment, type: :model do

  before do
    @user = User.create(name: "Orestis",email: "o@mail.com",password: "123456")
    @friend = User.create(name: 'Efrain',email: "e@mail.com",password: "123456")
    @post = @user.posts.create(content: "tests for post model")
    @comment = @user.comments.create(content: "comment for @user post", post_id: @post.id)
  end

  context "associations tests" do
    it "a comment should belong to a post" do
      expect(@comment.post.nil?).to be false
    end

    it "a comment should belong to a user" do
      expect(@comment.post.user).to_not be_nil
    end

    it "a comment should be deleted when it's user is destroyed" do
      @user.destroy
      expect { @comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it "a comment should be deleted when it's post is destroyed" do
      @post.destroy
      expect { @comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context "validations tests" do
    it "a comment should be valid" do
      expect(@comment).to be_valid
    end

    it "comment content shouldn't be longer than 140 characters" do
      @comment.content = 'a' * 141
      expect(@comment).to_not be_valid
    end
  end

end
