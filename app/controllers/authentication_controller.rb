class AuthenticationController < ApplicationController
  def confirm_authority
  end

  def confirm_authority_callback
    client = Cognito.new
    p params[:password]
    raise
    @res = client.initiate_auth(params[:email], params[:password])
    
  end
end
