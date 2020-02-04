class User < ApplicationRecord
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
                       format:{with:VALID_PASSWORD_REGEX}
  validates :nickname, presence:true, length:{maximum:15}
  validates_acceptance_of :agreement, allow_nil: false, on: :create
end
