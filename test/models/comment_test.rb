require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: 'Orestis', email: 'o@g.c', password: '123456')
    @post = @user.posts.create(content: "tests for post model")
    @comment = @post.comments.create(content: "comment for @user post")
  end

  test "a comment should be valid" do
    assert @comment.valid?
  end

  test "a comment should belong to a post" do
    assert_not @comment.post.nil?
  end

  test "a comment should belong to a user" do
    assert_not @comment.post.user.nil?
  end

  test "a comment should be deleted when it's user is destroyed" do
    @user.destroy
    assert_not @post.likes.exists?(@comment.id)
  end

  test "a comment should be deleted when it's post is destroyed" do
    @post.destroy
    assert_not @post.likes.exists?(@comment.id)
  end

  test "comment content shouldn't be longer than 140 characters" do
    @comment.content = 'a' * 141
    assert_not @comment.valid?
  end
end
