class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :reviews,dependent: :destroy
   has_many :movies, through: :reviews
   has_many :dramas, through: :reviews
  has_many :active_relationships, class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
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
                       format:{with:VALID_PASSWORD_REGEX}, on: :change_password
  validates :nickname, presence:true, length:{maximum:15}, on: :change_nickname
  validates_acceptance_of :agreement, :acceptance =>true, on: :change_agreement
  validates_acceptance_of :activated, :acceptance =>true, on: :change_activated
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
  
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil? or digest.empty?
    BCrypt::Password.new(digest).is_password?(token)
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
  
  #リセットトークンを生成する
  def create_reset_digest(token)
    if token == "password"
      self.reset_token = SecureRandom.urlsafe_base64
    else
      self.reset_token = sprintf("%.4d", rand(10000))
    end
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
  end
  
  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  #  Email再設定のメールを送信する
  def send_email_reset_email
    UserMailer.email_reset(self).deliver_now
  end
  
  # パスワード再設定の期限が切れている場合はtrueを返す
  def reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  private
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email.downcase!
    end
  

end
