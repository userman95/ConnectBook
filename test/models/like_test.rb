require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: 'Orestis', email: 'o@g.c', password: '123456')
    @another_user = User.create(name: 'Efrain', email: 'e@g.c', password: '123456')
    @post = @user.posts.create(content: "tests for post model")
    @like = @user.likes.create(post_id: @post.id)
  end

  test "a like should be valid" do
    assert @like.valid?
  end

  test "a like should belong to a post" do
    assert_not @like.post.nil?
  end

  test "a like should belong to a user" do
    assert_not @like.post.user.nil?
  end

  test "a like should be deleted when it's user is destroyed" do
    @user.destroy
    assert_not @post.likes.exists?(@like.id)
  end

  test "a like should be deleted when it's post is destroyed" do
    @post.destroy
    assert_not @post.likes.exists?(@like.id)
  end
end
