class Cognito
  def initialize
    @client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['region'],
      access_key_id: ENV['AccessKeyId'],
      secret_access_key: ENV['SecretAccessKey'])
  end

# resp = client.admin_get_user({
#   user_pool_id: ENV['UserPoolId'],
#   username: 'shintanakama018@gmail.com',})

  # 認証実行API,問題があれば
  def initiate_auth(email, pass)
    res = @client.admin_initiate_auth({
      auth_flow: 'ADMIN_NO_SRP_AUTH',
      # auth_flow: 'USER_PASSWORD_AUTH',
      auth_parameters: {
        # USERNAME: "shintanakama018@gmail.com",
        USERNAME: email,
        # PASSWORD: "Asukayukito018"
        # PASSWORD: "t9LAT#4F"
        PASSWORD: pass
      },
      client_id: ENV['appClientId'],
      user_pool_id: ENV['UserPoolId']
    })
  end

  # 初回ログイン後のpassword変更
  def challenge_auth(email, pass, challenge_name, initiate_auth_session)
    result = @client.admin_respond_to_auth_challenge({
      user_pool_id: ENV['UserPoolId'],
      client_id: ENV['appClientId'],
      # challenge_name: "#{res.challenge_name}",
      challenge_name: challenge_name,
      challenge_responses: {
        # "NEW_PASSWORD": "Asukayukito018",
        # "USERNAME": "shintanakama018@gmail.com"
        "NEW_PASSWORD": pass,
        "USERNAME": email
      },
      # session: "#{res.session}",
      session: initiate_auth_session,
    })
  end

  def sign_out(email)
    resp = @client.admin_user_global_sign_out({
      user_pool_id: ENV['UserPoolId'],
      username: email,
    })
  end

  def reset_pass
    resp = @client.admin_reset_user_password({
      user_pool_id: ENV['UserPoolId'],
      username: email,
    })
  end
end