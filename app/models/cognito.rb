class Cognito
  def initialize(email, pass='pass')
    @client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['region'],
      access_key_id: ENV['AccessKeyId'],
      secret_access_key: ENV['SecretAccessKey'])
    @email = email
    @pass = pass
  end

  # 認証実行API,問題があれば
  def initiate_auth
    begin
      @client.admin_initiate_auth({
        auth_flow: 'ADMIN_NO_SRP_AUTH',
        auth_parameters: {
          USERNAME: @email,
          PASSWORD: @pass
        },
        client_id: ENV['appClientId'],
        user_pool_id: ENV['UserPoolId']
      })
    rescue => e
    # rescue => InvalidParameterException
      'not_auth'
    end
  end

  # 初回ログイン後のpassword変更
  def challenge_auth(challenge_name, initiate_auth_session)
    result = @client.admin_respond_to_auth_challenge({
      user_pool_id: ENV['UserPoolId'],
      client_id: ENV['appClientId'],
      # challenge_name: "#{res.challenge_name}",
      challenge_name: challenge_name,
      challenge_responses: {
        # "NEW_PASSWORD": "Asukayukito018",
        # "USERNAME": "shintanakama018@gmail.com"
        "NEW_PASSWORD": @pass,
        "USERNAME": @email
      },
      # session: "#{res.session}",
      session: initiate_auth_session,
    })
  end

  def sign_out
    @client.admin_user_global_sign_out({
      user_pool_id: ENV['UserPoolId'],
      username: @email,
    })
  end

  def reset_pass
    resp = @client.admin_reset_user_password({
      user_pool_id: ENV['UserPoolId'],
      username: @email,
    })
  end
end