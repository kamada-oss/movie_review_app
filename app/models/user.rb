class User < ApplicationRecord
  attr_accessor :remember_token
  before_save{email.downcase!}
  validates :name, presence:true, length:{maximum:15},
                   uniqueness:true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum:255},
                    format:{with:VALID_EMAIL_REGEX},
                    uniqueness:{case_sensitive:false}
  has_secure_password
  VALID_PASSWORD_REGEX = /\A\w+$\z/i
  validates :password, presence:true, length:{minimum:5},
                       format:{with:VALID_PASSWORD_REGEX}, allow_nil: true
  validates :nickname, presence:true, length:{maximum:15}
  validates_acceptance_of :agreement, allow_nil: false, on: :create
  validates :profile, length:{maximum:1200}
  
  
  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  #永続セッションの為、ユーザーをデータベースに登録する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end