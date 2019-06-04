class FriendRequest < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  # the idea is to create a friend request and then accept it like this:
  # (receiver_user).friend_requests.create(friend: sender_user)
  # and then to accept it: current_user.friend_requests.accept

  validate :existence_of_friendship
  validate :uniqueness_of_friend_request
  validate :exclude_self_friend_request

  def accept
    user.friends << friend
    destroy
  end

  def decline
    destroy
  end

  private

  def existence_of_friendship
    errors.add(:friend,'friends already added') if user.friends.include?(friend)
  end

  def uniqueness_of_friend_request
    errors.add(:friend,'you have already sent a friend request to that user') if friend.pending_friends.include?(user)
  end

  def exclude_self_friend_request
    errors.add(:friend, "can't be equal to user") if user == friend
  end

end
