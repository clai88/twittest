class User < ActiveRecord::Base
  has_many :tweets
  validates :email, format: {with: /@/}, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, too_short: "Please make your password at least 6 characters long"  },confirmation: true

  def self.sign_up(user_hash)
    User.create(user_hash)
  end

  has_secure_password #new way
end
