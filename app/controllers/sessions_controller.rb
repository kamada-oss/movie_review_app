class SessionsController < ApplicationController
  def new
    @page_view = 0
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "メールアドレスもしくはパスワードが不正です"
      @page_view = 1
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
