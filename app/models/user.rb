class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :requests, 
           class_name: "Friendship",
           foreign_key: :sender_id,
           dependent: :destroy
  has_many :invitations,
           class_name: "Friendship",
           foreign_key: :receiver_id,
           dependent: :destroy

  # Invitations pending to accept
  has_many :invitations_from, through: :invitations, source: :sender
  # Requests made to other friends
  has_many :requests_to, through: :requests, source: :receiver

  has_many :posts
  has_many :likes
  has_many :comments

  validates :name, presence: true
end
