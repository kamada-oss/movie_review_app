class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
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
  
  def update
    @user.assign_attributes(user_params)
    if @user.save(context: :change_password)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードが正しく変更されました。"
      redirect_to announce_success_change_password_path
    else
      render 'edit'                                     
    end
  end
  
  def announce_success_change_password
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
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.reset_expired?
        flash[:danger] = "パスワードの再設定に失敗しました。URLをご確認ください。"
        redirect_to new_password_reset_url
      end
    end
end
