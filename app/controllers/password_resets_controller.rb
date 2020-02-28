class PasswordResetsController < ApplicationController
  def new
    @failed_submit = 0
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:warning] = "パスワードの再設定について数分以内にメールでご連絡いたします。"
      redirect_to announce_send_password_path
    else
      @failed_submit = 1
      render 'new'
    end
  end
  
  def announce_send_password
  end
end
