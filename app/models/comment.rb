class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :content, presence: true
end
