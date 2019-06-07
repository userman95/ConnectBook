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
    user.added_by_friends << friend
    destroy
  end

  def decline
    destroy
  end

  private

    def existence_of_friendship
      errors.add(:friendship, "already exists") if user.friends.include?(friend)
    end

    def uniqueness_of_friend_request
      if user.users_in_request.include?(friend) || friend.users_in_request.include?(user)
        errors.add(:friend_request, "already exists")
      end
    end

    def exclude_self_friend_request
      errors.add(:friend_request, "to itself not allowed") if user == friend
    end

end
