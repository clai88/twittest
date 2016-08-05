class User < ActiveRecord::Base
  validates :email, format: {with: /@/}, uniqueness: true
  validates :password_digest, presence: true
  validates :password, confirmation: true

  def self.sign_up(user_hash)
    User.create(user_hash)
  end

  has_secure_password

  # def password=(other)
  #   digest = BCrypt::Password.create(other)
  #   self.password_digest = digest
  # end
  #
  # def password
  #   BCrypt::Password.new(self.password_digest)
  # end

end
