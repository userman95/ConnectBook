class User < ApplicationRecord
  has_many :senders, class_name: "Friendship", foreign_key: :sender_id
  has_many :receivers, class_name: "Friendship", foreign_key: :receiver_id

  has_many :user_invitations, through: :receivers, source: :sender
  has_many :invited_users, through: :senders, source: :receiver
end

# class Friend
#   has_many :friendships, foreign_key: :receiver_id
#   has_many :user_invitations, through: :friendships, source: :sender
# end

# class User
#   has_and_belongs_to_many :follows,
#       class_name: "User",
#       foreign_key: "user_id",
#       association_foreign_key: "followed_user_id",
#       join_table: :follows
# end
