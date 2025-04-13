class User < ApplicationRecord
  has_secure_password

  has_many :events, foreign_key: :user_id, dependent: :destroy
  has_many :bookings

  before_create :generate_jti

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[customer organizer] }

  def generate_jti
    self.jti = SecureRandom.uuid
  end

  def invalidate_jti!
    update!(jti: SecureRandom.uuid)
  end

  def organizer?
    role == "organizer"
  end

  def customer?
    role == "customer"
  end
end
