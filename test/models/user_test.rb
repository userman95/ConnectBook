require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: 'Efrain', email: 'e@g.c', password: '123456')
    @receiver = User.new(name: 'Orestis', email: 'o@g.c', password: '123456')
  end

  test "user should be valid" do
    assert @user.valid?
  end

  # We need to validate user name manually in the model because it isn't
  # a default field for Devise
  test "user name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "user email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "user email should have valid format" do
    @user.email = "user.c"
    assert_not @user.valid?
  end

  test "user password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "user password should be more that or equal to 6 characters long" do
    @user.password = "1234"
    assert_not @user.valid?
  end

  test "user should send friend requests" do
    @user.invited_users << @receiver
    assert_equal @user.invited_users.size, 1
  end

  test "user should receive friend requests" do
    @receiver.user_invitations << @user
    assert_equal @receiver.user_invitations.size, 1
  end

  test "user can accept a friend request" do
    @receiver.user_invitations << @user
    
  end
end
