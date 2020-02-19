# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at https://f1b757c6b5ae47edb64af4d127b200b0.vfs.cloud9.us-east-2.amazonaws.com/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = sprintf("%.4d", rand(10000))
    UserMailer.account_activation(user)
  end

  # Preview this email at https://f1b757c6b5ae47edb64af4d127b200b0.vfs.cloud9.us-east-2.amazonaws.com/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

end
