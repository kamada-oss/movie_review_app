class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  
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
  
  def edit
  end

  
  
  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
end
