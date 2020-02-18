class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  #before_create :create_activation_digest
  validates :name, presence:true, length:{maximum:15},
                   uniqueness:true, on: :change_name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum:255},
                    format:{with:VALID_EMAIL_REGEX},
                    uniqueness:{case_sensitive:false}, on: :change_email
  has_secure_password
  VALID_PASSWORD_REGEX = /\A\w+$\z/i
  validates :password, presence:true, length:{minimum:5},
                       format:{with:VALID_PASSWORD_REGEX}, allow_nil: true, on: :change_password
  validates :nickname, presence:true, length:{maximum:15}, on: :change_nickname
  validates_acceptance_of :agreement, :acceptance =>true, on: :change_agreement
  validates :profile, length:{maximum:1200}, on: :change_profile
  
  
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
  
  #アクティベーショントークンを生成する
  def create_activation_digest
    self.activation_token = sprintf("%.4d", rand(10000))
    self.activation_digest = User.digest(activation_token)
  end
  
  private
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email.downcase!
    end
  

end
