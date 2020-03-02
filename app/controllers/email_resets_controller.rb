class EmailResetsController < ApplicationController
  before_action :logged_in_user, only:[:new,:create,:edit,:update]
  before_action :correct_user, only:[:new,:create,:edit,:update]
  
  
  def new
    @user = User.find(params[:id])
    @failed_submit = 0
  end
  
  def create
    @user = User.find(params[:id])
    email = @user.email
    @user.assign_attributes(user_params)
    if @user.email ==email
      @failed_submit = 1
      render 'new'
    elsif @user.valid?(:change_email)
      @user.create_reset_digest("email")
      @user.send_email_reset_email
      redirect_to edit_email_reset_path(id: @user.id, email: @user.email)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.assign_attributes(email: params[:email])
    @failed_authenticate = 0
  end
  
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(email: params[:email])
    if @user.authenticated?(:reset, params[:email_reset][:reset_token]) && @user.save(context: :change_email)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "メールアドレスが正しく変更されました。"
      redirect_to "/email_resets/#{@user.id}/new"
    else
      @failed_authenticate = 1
      flash.now[:danger] = "メールアドレスの変更が出来ませんでした"
      render 'edit'
    end
  end
  
  private
  
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "ログインしてください"
          redirect_to login_url
        end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
    def user_params
      params.require(:user).permit(:email)
    end
end
