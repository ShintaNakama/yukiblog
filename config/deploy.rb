# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "yukiblog"
set :repo_url, "git@github.com:ShintaNakama/yukiblog.git"
set :user, "nakamashinta"

# # Default branch is :master
# # ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# # set :branch, feature/gce_version

# # Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/yukiblog"

# # Default value for :format is :airbrussh.
# # set :format, :airbrussh
# set :format, :pretty
# set :log_level, :debug

# # You can configure the Airbrussh format using :format_options.
# # These are the defaults.
# # set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# # Default value for :pty is false
# set :pty, true

# # Default value for :linked_files is []

# # append :linked_files, "config/master.key"
set :linked_files, fetch(:linked_files, []).push("config/master.key") 

# # Default value for linked_dirs is []
# # append :linked_dirs, "log", "tmp", ".bundle"
# set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# # Default value for default_env is {}
# # set :default_env, { path: "/opt/ruby/bin:$PATH" }

# # Default value for local_user is ENV['USER']
# # set :local_user, -> { `git config user.name`.chomp }
# # rbenvをシステムにインストールしたか? or ユーザーローカルにインストールしたか?
# # set :rbenv_type, :user # :system or :user
# # set :rbenv_ruby, File.read('.ruby-version').strip
# # set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# # set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# # set :rbenv_roles, :all # default value

# # pumaの設定
# set :stage,           :production
# set :deploy_via,      :remote_cache
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.access.log"
# set :puma_error_log,  "#{release_path}/log/puma.error.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true  # Change to false when not using ActiveRecord
# # rbenvをユーザローカルにインストールする場合に必要
# append :rbenv_map_bins, 'puma', 'pumactl'

# # Default value for keep_releases is 5
# set :keep_releases, 1

# bundle installの並列実行数
set :bundle_jobs, 4
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
# set :deploy_to,       'SERVER_PATH'
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :rbenv_type, :system
set :rbenv_path, '/usr/local/rbenv'
# set :rbenv_path, '~/.rbenv/bin/rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/uploads'
) 
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end
 
namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
      end
    end
  end
 
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end
 
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
 
  desc 'reload the database with seed data'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
 
  after  :migrate,      :seed
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end
# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


# ruby_version
# set :rbenv_ruby, '2.5.0'

