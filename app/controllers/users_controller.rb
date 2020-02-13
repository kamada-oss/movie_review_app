class UsersController < ApplicationController
  protect_from_forgery
  before_action :logged_in_user, only:[:edit_prof,:update_prof,:edit_account,:edit_email,:edit_password,:update_password]
  before_action :correct_user, only:[:edit_prof,:update_prof,:edit_account,:edit_email,:edit_password,:update_password]
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def confirm
    @user = User.new(user_params)
    render 'new' if @user.invalid?
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render 'new'
    elsif @user.save
      log_in(@user)
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit_prof
    @user = User.find(params[:id])
  end
  
  def update_prof
    @user = User.find(params[:id])
    logged_in?
    if @user.update_attributes(user_params)
      flash[:success] = "設定を保存しました"
      redirect_to action: 'edit_prof'
    else
      render :edit_prof
    end
  end
  
  def edit_account
    @user = User.find(params[:id])
  end
  
  def edit_email
    @user = User.find(params[:id])
  end
  
  def edit_password
    @user = User.find(params[:id])
  end
  
  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "パスワード変更が完了しました"
      redirect_to action: 'edit_password'
    else
      flash.now[:danger] = "パスワードが変更できませんでした"
      render 'edit_password'
    end
  end
  
  def index
    @users = User.all  
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :agreement, :profile)
    end
    
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
end
