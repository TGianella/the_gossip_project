class Gossip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :likes
  validates :title,
            presence: true,
            length: { maximum: 20 }
  validates :content, presence: true
end
