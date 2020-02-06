class UsersController < ApplicationController
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
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :agreement)
    end
end
