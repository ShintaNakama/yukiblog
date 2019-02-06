if Rails.env.production?
  require 'faraday_middleware/aws_sigv4'
  require 'patron'

  Elasticsearch::Model.client = Elasticsearch::Client.new(
    url: 'https://search-myapp-xxxxxxxxxxxxxxxxxxx.ap-northeast-1.es.amazonaws.com'
  ) do |f|
    f.request :aws_sigv4,
              service: 'es',
              access_key_id: ENV['AccessKeyId'], # 先ほど設定したIAMユーザーのaccess key id
              secret_access_key: ENV['SecretAccessKey'], # 先ほど設定したIAMユーザーのsecret access key
              region: 'ap-northeast-1'
    f.adapter :patron
  end
else
  Elasticsearch::Model.client = Elasticsearch::Client.new({log: true, hosts: { host: 'myapp-elasticsearch'}})
end