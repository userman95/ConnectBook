class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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

  has_many :posts, dependent: :destroy
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  validates :name, presence: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

end
