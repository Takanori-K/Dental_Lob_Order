class User < ApplicationRecord
  before_save { self.email = email.downcase }
  
  validates :password, presence: true, length: {minimum: 8}, on: :facebook_login
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  validates :password, presence: false, on: :facebook_login

    def self.from_omniauth(auth)
      # emailの提供は必須とする
      user = User.where('email = ?', auth.info.email).first
      if user.blank?
        user = User.new
      end
      user.uid   = auth.uid
      user.name  = auth.info.name
      user.email = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user
    end
end
