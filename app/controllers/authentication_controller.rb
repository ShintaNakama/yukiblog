class AuthenticationController < ApplicationController
  def confirm_authority
  end

  def confirm_authority_callback
    client = Cognito.new
    p params[:email]
    p params[:password]
    # API access
    if session[:challenge_name] = 'NEW_PASSWORD_REQUIRED'
      challenge_name = session[:challenge_name]
      initiate_auth_session = session[:initiate_tag] 
      res = client.challenge_auth(params[:email], params[:password], challenge_name, initiate_auth_session)
    else
      res = client.initiate_auth(params[:email], params[:password])
    end
    # response type check 
    if res.challenge_name.present?
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
    elsif res.authentication_result.present?
      flash[:notice] = 'login ok'
      session[:admin] = res.authentication_result.access_token
      redirect_to articles_path
    else
      flash[:notice] = 'not login'
      logger.debug(res)
      redirect_to articles_path
    end
  end
end
