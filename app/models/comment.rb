class Comment < ApplicationRecord
  include Liked

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  validates :content, presence: true
end
