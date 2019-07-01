require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: 'Orestis', email: 'o@g.c', password: '123456')
    @post = @user.posts.create(content: "tests for post model")
  end

  test "post should be valid" do
    assert @post.valid?
  end

  test "post should be present" do
    @post.content = ' '
    assert_not @post.valid?
  end

  test "post should belong to a user" do
    assert_not @post.user.nil?
  end

  test "post content shouldn't be longer than 140 characters" do
    @post.content = 'a' * 141
    assert_not @post.valid?
  end

  test "all posts of the user should be destroyed when a user is destroyed" do
    @user.destroy
    assert_not Post.exists?(@post.id)
  end
end
