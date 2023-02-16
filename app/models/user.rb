class User < ApplicationRecord
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'PrivateMessage'
  has_and_belongs_to_many :received_messages, class_name: 'PrivateMessage'
  belongs_to :city
  has_many :gossips
  has_many :comments
  has_many :likes
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description,
            presence: true,
            length: { maximum: 500 }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'email adress please' }
  validates :age, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    update!(remember_digest: remember_digest)
  end
end
