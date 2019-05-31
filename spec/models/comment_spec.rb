require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "a comment should be valid" do
    @user = create(:user)
    @another_user = create(:user,name: 'Efrain', email: 'e@g.c')
    @post = @another_user.posts.create(content: "tests for post model")
    @comment = @user.comments.create(content: "comment for @user post", post_id: @post.id)
    assert @comment.valid?
  end

  it "a comment should belong to a post" do
    assert_not @comment.post.nil?
  end

  it "a comment should belong to a user" do
    assert_not @comment.post.user.nil?
  end

  it "a comment should be deleted when it's user is destroyed" do
    @user.destroy
    assert_not @post.likes.exists?(@comment.id)
  end

  it "a comment should be deleted when it's post is destroyed" do
    @post.destroy
    assert_not @post.likes.exists?(@comment.id)
  end

  it "comment content shouldn't be longer than 140 characters" do
    @comment.content = 'a' * 141
    assert_not @comment.valid?
  end
end
