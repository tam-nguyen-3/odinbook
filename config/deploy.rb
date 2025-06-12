# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "odinbook"
set :repo_url, "git@github.com:tam-nguyen-3/odinbook.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'main'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/odinbook"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# puma
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_conf, "#{shared_path}/puma.rb"

set :puma_preload_app, true
set :puma_init_active_record, true
set :puma_preload_app, false

set :ssh_options, {
  forward_agent: false,
  user: 'ec2-user',
  keys: %w(~/.ssh/id_rsa)
}

# nginx
set :nginx_config_name, 'odinbook'
set :nginx_server_name, 'odinbook'
set :nginx_use_ssl, false # will be handled by certbot
