class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :senders, class_name: "Friendship", foreign_key: :sender_id
  has_many :receivers, class_name: "Friendship", foreign_key: :receiver_id

  has_many :user_invitations, through: :receivers, source: :sender
  has_many :invited_users, through: :senders, source: :receiver

  has_many :posts
  has_many :likes
  has_many :comments
end
