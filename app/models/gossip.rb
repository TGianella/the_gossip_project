class Gossip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
  has_many :likes
  validates :title,
            presence: true,
            length: { maximum: 20 }
  validates :content, presence: true

  def liked?(user)
    !!likes.find { |like| like.user_id == user.id }
  end
end
