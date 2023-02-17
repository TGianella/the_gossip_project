class Tag < ApplicationRecord
  include Liked
  has_and_belongs_to_many :gossips
  has_many :likes, as: :likeable, dependent: :destroy
end
