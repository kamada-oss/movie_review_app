class UsersController < ApplicationController
  protect_from_forgery
  before_action :logged_in_user, only:[:edit_prof,:update_prof,:edit_account,
                                       :edit_email,:edit_password,:update_password, :destroy]
  before_action :correct_user, only:[:edit_prof,:update_prof,:edit_account,:edit_email,:edit_password,:update_password, ]
  before_action :admin_user, only:[:destroy]
  
  def new
    @user = User.new
    @user.email = params[:email]
    @user.activation_digest = params[:activation_digest]
    @user.activated_at = params[:activated_at]
    @user.activated = params[:activated]
    activated_user
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
    @user.activation_digest = params[:activation_digest]
  end
  
  def authenticate_authcode
    @user = User.new(email: params[:email])
    @user.activation_digest = params[:activation_digest]
    if @user.authenticated?(:activation, params[:authenticate][:authcode])
      @user.activated = true
      @user.activated_at = Time.zone.now
      redirect_to action: 'new', email: @user.email, activation_digest: @user.activation_digest, 
                                 activated_at: @user.activated_at, activated: @user.activated
    else
      flash.now[:danger] = "認証番号が間違っているか、認証期間が無効です"
      render 'enter_authcode'
    end
  end
  
  def confirm
    @user = User.new(user_params)
    render 'new' if @user.invalid?([:change_name, :change_password, :change_nickname, 
                                    :change_agreement, :change_activated, :change_email])
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render 'new'
    elsif @user.save(context: [:change_name, :change_password, :change_nickname, 
                    :change_agreement, :change_activated, :change_email])
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
    @user.assign_attributes(user_params)
    if @user.save(context: [:change_nickname, :change_profile])
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
    @user.assign_attributes(user_params)
    if  @user.save(context: :change_password)
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, 
                                   :agreement, :profile, :activated, :activated_at, :activation_digest)
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
    
    def activated_user
      redirect_to send_activation_email_path unless @user.activated
    end
end
