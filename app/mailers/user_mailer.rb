class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject:"Kamarksご本人さま確認メール：認証番号のお知らせ"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject:"[Kamarks]パスワード再設定について"
  end
  
  def email_reset(user)
    @user = user
    mail to: user.email, subject:"Kamarksご本人さま確認メール：認証番号のお知らせ"
  end
end
