class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable
         
  has_many :sent_requests, 
           class_name: "Friendship",
           foreign_key: :sender_id,
           dependent: :destroy
  has_many :received_requests,
           class_name: "Friendship",
           foreign_key: :receiver_id,
           dependent: :destroy

  # Requests made to other friends
  has_many :requests_to, through: :sent_requests, source: :receiver
  # Invitations pending to accept
  has_many :invitations_from, through: :received_requests, source: :sender

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
end
