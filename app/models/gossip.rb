class Gossip < ApplicationRecord
  include Liked

  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title,
            presence: true,
            length: { maximum: 20 }
  validates :content, presence: true
end
