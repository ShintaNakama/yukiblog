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

  def initiate_auth(email, pass)
    res = @client.admin_initiate_auth({
      auth_flow: 'ADMIN_NO_SRP_AUTH',
      # auth_flow: 'USER_PASSWORD_AUTH',
      auth_parameters: {
        USERNAME: "shintanakama018@gmail.com",
        PASSWORD: "Asukaykito018"
      },
      client_id: ENV['appClientId'],
      user_pool_id: ENV['UserPoolId']
    })
  end

  # 初回ログイン後のpassword変更
  def challenge_auth
    result = @client.admin_respond_to_auth_challenge({
      user_pool_id: ENV['UserPoolId'],
      client_id: ENV['appClientId'],
      challenge_name: "#{res.challenge_name}",
      challenge_responses: {
        "NEW_PASSWORD": "Asukaykito018",
        "USERNAME": "shintanakama018@gmail.com"
      },
      session: "#{res.session}",
    })
  end

  def sign_out
    resp = @client.admin_user_global_sign_out({
      user_pool_id: ENV['UserPoolId'],
      username: "shintanakama018@gmail.com",
    })
  end
end