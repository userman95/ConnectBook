class Friendship < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'

  before_validation :check_duplicates, on: :create

  validates :user, presence: true, uniqueness: { scope: :friend }
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :friendship_uniqueness
  validate :self_friendship


  private

    # Validations

    def friendship_uniqueness
      if user && friend
        if user.friends.include?(friend) || friend.friends.include?(user)
          errors.add(:friendship,'already exists')
        end
      end
    end

    def self_friendship
      errors.add(:friendship, "to itself") if user == friend
    end

    # Callbacks

    def check_duplicates
      return unless Friendship.where(user: user, friend: friend).empty?
      self.user, self.friend = friend, user
    end

end
