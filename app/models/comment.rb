class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: {maximum: 140}

end
