class AuthenticationController < ApplicationController
  def confirm_authority
  end

  def confirm_authority_callback
    client = Cognito.new(
      authentication_params[:email], authentication_params[:password])
    # API access
    if session[:challenge_name] == 'NEW_PASSWORD_REQUIRED'
      challenge_name = session[:challenge_name]
      initiate_auth_session = session[:initiate_tag] 
      res = client.challenge_auth(challenge_name, initiate_auth_session)
    else
      res = client.initiate_auth
    end
    # response type check 
    # params miss
    if res == 'not_auth'
      flash[:notice] = 'emailかpassが間違っています。'
      redirect_to articles_path
    # challenge
    elsif res.challenge_name.present?
      case res.challenge_name
      when 'NEW_PASSWORD_REQUIRED'
        flash[:notice] = 'passwordを変更してください'
        session[:challenge_name] = res.challenge_name
        session[:initiate_tag] = res.session
        redirect_to articles_path
      else
        flash[:notice] = 'status error'
        redirect_to articles_path
      end
    # auth true
    elsif res.authentication_result.present?
      flash[:notice] = 'login ok'
      session.delete(:challenge_name) if session[:challenge_name].present?
      session.delete(:initiate_tag) if session[:initiate_tag].present?
      session[:email] = params[:email]
      session[:admin] = res.authentication_result.access_token
      redirect_to articles_path
    else
      flash[:notice] = 'emailかpassが間違っています。'
      redirect_to articles_path
    end
  end

  def logout
    client = Cognito.new(session[:email])
    res = client.sign_out
    session.delete(:email)
    session.delete(:admin)
    flash[:notice] = 'logout'
    redirect_to articles_path 
  end

  private
    def authentication_params
      params.permit(:email, :password)
    end
end