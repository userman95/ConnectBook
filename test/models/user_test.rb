require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: 'Efrain', email: 'e@g.c', password: '123456')
    @receiver = User.create(name: 'Orestis', email: 'o@g.c', password: '123456')
  end

  test "user should be valid" do
    assert @user.valid?
  end

  # We need to validate user name manually in the model because it isn't
  # a default field on Devise
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
    @user.save
    @receiver.save
    @user.requests_to << @receiver
    assert_equal @user.requests.size, 1
  end

  test "user should receive friend requests" do
    @user.save
    @receiver.save
    @user.requests_to << @receiver
    assert_equal @receiver.invitations.size, 1
  end

  test "user can accept a friend request" do
    @user.save
    @receiver.save
    @user.requests_to << @receiver
    user_friend_request = @receiver.invitations.find_by(sender_id: @user.id)
    user_friend_request.accepted = true
    assert user_friend_request.accepted?
  end

  test "a friendship should be destroyed when the requester is deleted" do
    requester = users(:user1)
    invited = users(:user2)
    requester.requests_to << invited

    assert_difference 'Friendship.count', -1 do
      requester.destroy
    end
  end

  test "a friendship should be destroyed when the invited user is deleted" do
    requester = users(:user1)
    invited = users(:user2)
    requester.requests_to << invited
    
    assert_difference 'Friendship.count', -1 do
      invited.destroy
    end
  end

end
