class City < ApplicationRecord
  include Liked

  has_many :users
  has_many :gossips, through: :users
  has_many :likes, as: :likeable, dependent: :destroy
end
