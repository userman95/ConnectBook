class Friendship < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true
  validate :friendship_uniqueness
  validate :self_friendship


  private
  
    def friendship_uniqueness
      if user.friends.include?(friend) || friend.friends.include?(user)
        errors.add(:friendship,'already exists')
      end
    end

    def self_friendship
      errors.add(:friendship, "to itself") if user == friend
    end
end
