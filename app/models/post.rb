class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: {maximum: 140}

  scope :newer_posts, -> {order(created_at: :desc)}
end
