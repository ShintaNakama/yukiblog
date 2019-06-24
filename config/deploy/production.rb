# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
set :stage, :production
set :rails_env, 'production'
 
# set :branch, ENV['BRANCH_NAME'] || 'master'
set :branch, 'master'
# gitのbranchチェック設定
# set :enable_git_confirmation, true
 
# set :migration_role, 'db'
# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value

# migrate設定
# set :migration_role, %w{db}
# set :conditionally_migrate, true
# set :migration_environments, ['production']

# puma設定
set :puma_threads, [4, 16] # DBプール数に合わせる
set :puma_workers, 2 # CPUコア数〜1.5倍を基本と考える
set :puma_worker_killer_ram, 6144 # 搭載メモリの80%程度をよしなに設定
set :puma_daemonize, true # デーモン化を有効にしておく
set :puma_control_app, true

# server "35.243.71.228", user: "nakamashinta", roles: %w{app web}, other_property: :other_value
server "35.243.71.228", user: "nakamashinta", roles: %w{web app}

# server "10.45.128.3 ", user: "root", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{root@10.45.128.3}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
 set :ssh_options, {
   keys: %w(~/.ssh/google_compute_engine),
   forward_agent: true,
   auth_methods: %w(publickey)
 }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
