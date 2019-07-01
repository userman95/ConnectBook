class Post < ApplicationRecord
  belongs_to :user #maybe has and belongs to many so that we are
                   #able to publish a post into a friends page
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
