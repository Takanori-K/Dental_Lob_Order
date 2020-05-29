class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  mount_uploader :image, ImageUploader
  attr_accessor :remember_token
  before_save :downcase_email
  
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, unless: :uid?
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, if: :uid_present_email_valid?, on: :update
  has_secure_password validations: false
  
  validate(if: :blank_uid?) do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  validates_length_of :password, minimum: 6, allow_blank: true, if: :blank_uid?
  validates_confirmation_of :password, allow_blank: true, if: :blank_uid?
  
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true, if: :blank_uid?
  
  
  def downcase_email
    if uid.blank? || (uid.present? && email.present?)
      self.email = email.downcase
    end
  end
  
  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]
    image = auth[:info][:image]
    #必要に応じて情報追加してください
    
    #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.email = email
      user.remote_image_url = image.gsub("picture","picture?type=large") if provider == "facebook"
      user.remote_image_url = image if provider == "line"
    end
  end
  
  def blank_uid?
    uid.blank? || provider.blank?
  end
  
  def uid_present_email_valid?
    uid.present? && email.present?
  end
  
end
