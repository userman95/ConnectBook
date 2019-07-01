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
    assert_equal 1, @user.sent_requests.size
  end

  test "user should receive friend requests" do
    @user.save
    @receiver.save
    @user.requests_to << @receiver
    assert_equal 1, @receiver.received_requests.size
  end

  test "user can accept a friend request" do
    @user.save
    @receiver.save
    @user.requests_to << @receiver
    user_friend_request = @receiver.received_requests.find_by(sender_id: @user.id)
    user_friend_request.accepted = true
    user_friend_request.save
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

  test "a user should get all his pending requests" do
    requester = users(:user1)
    users = User.where("name LIKE '%friend%'").take(20)
    users.each do |user|
      requester.requests_to << user
    end
    assert_equal requester.sent_requests.count, 20
  end

  test "a user should get all his accepted requests" do
    requester = users(:user1)
    users = User.where("name LIKE '%friend%'").take(20)
    users.each do |user|
      requester.requests_to << user
    end
    friend1 = users(:someone1)
    friend1_invitation = friend1.received_requests.find_by(sender_id: requester.id)
    friend1_invitation.accepted = true
    friend1_invitation.save
    assert_equal 1, requester.sent_requests.where(accepted: true).count
  end

  test "a user should get all the requests it already accepted" do
    invited = users(:user1)
    requester1 = users(:someone1)
    requester2 = users(:someone2)
    requester3 = users(:someone3)
    requester1.requests_to << invited
    requester2.requests_to << invited
    requester3.requests_to << invited
    
    invitation = invited.received_requests.find_by(sender_id: requester1.id)
    invitation.accepted = true
    invitation.save
    invitation = invited.received_requests.find_by(sender_id: requester2.id)
    invitation.accepted = true
    invitation.save

    assert_equal 2, invited.received_requests.where(accepted: true).count
    assert_equal 1, invited.received_requests.where(accepted: false).count
  end

end
