class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likeable, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates :content, presence: true, length: {maximum: 140}

end
