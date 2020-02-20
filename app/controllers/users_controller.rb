class UsersController < ApplicationController
  protect_from_forgery
  before_action :logged_in_user, only:[:edit_prof,:update_prof,:edit_account,
                                       :edit_email,:edit_password,:update_password, :destroy]
  before_action :correct_user, only:[:edit_prof,:update_prof,:edit_account,:edit_email,:edit_password,:update_password, ]
  before_action :admin_user, only:[:destroy]
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def enter_activaton_email
    @user = User.new
  end
  
  def send_activaton_email
    @user = User.new(user_params)
    @user.password = "password"
    if @user.valid?(:change_email)
      @user.password = nil
      @user.create_activation_digest
      UserMailer.account_activation(@user).deliver_now
      redirect_to action: 'enter_authcode', email: @user.email, activation_digest: @user.activation_digest
    else
      @user.password = nil
      render 'enter_activaton_email'
    end
  end
  
  def enter_authcode
    @user = User.new(email: params[:email])
    @activation_digest = params[:activation_digest]
  end
  
  def authenticate_authcode
    @user = User.new(email: params[:email])
    activation_digest = params[:activation_digest]
    authcode = params[:authenticate][:authcode]
    
    
    redirect_to signup_url
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
  
  def withdraw
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all  
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "退会が完了しました"
    redirect_to root_url
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
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user.admin? || current_user?(@user)
    end
end
