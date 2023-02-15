class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment, optional: true
  belongs_to :gossip, optional: true
  validates :user_id, uniqueness: { scope: :gossip_id }
end
