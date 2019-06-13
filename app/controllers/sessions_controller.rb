class SessionsController < ApplicationController
  # skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user.admin && user&.authenticate(session_params[:password])
      session[:admin] = user.id
      redirect_to articles_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to articles_path, notice: 'ログアウトしました。'
  end

  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
