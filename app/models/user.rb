class User < ApplicationRecord
  before_save { self.email = email.downcase }
  
  validates :password, presence: true, length: {minimum: 8}, on: :facebook_login
  validates :name, presence: true, length: { maximum: 50 }, unless: :uid?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true,
                    unless: :uid?
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 6 }, unless: :uid?

    def self.find_or_create_from_auth(auth)
      provider = auth[:provider]
      uid = auth[:uid]
      name = auth[:info][:name]
      #必要に応じて情報追加してください
    
      #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
      self.find_or_create_by(provider: provider, uid: uid) do |user|
        user.name = name
      end
    end
end
