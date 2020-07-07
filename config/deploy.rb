# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.12.1'

set :application, 'automation'
set :repo_url, 'https://github.com/kamilsluszniak/automation'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/deploy/automation'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml'
append :linked_files, 'config/application.yml'
append :linked_files, 'config/secrets.yml'
append :linked_files, 'config/master.key'

# Default value for linked_dirs is []
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads]
append :linked_dirs, '.bundle'

set :bundle_gemfile, -> { release_path.join('Gemfile') } # default: nil
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { path: "~/.asdf/shims:~/.asdf/bin:$PATH" }
# set :asdf_custom_path, '~/.my_asdf_installation_path'  # only needed if not '~/.asdf'
# set :asdf_tools, %w{ ruby }                            # defaults to %{ ruby nodejs }
# set :asdf_map_ruby_bins, %w{ bundle gem }              # defaults to %w{ rake gem bundle ruby rails }
# set :asdf_map_nodejs_bins, %w{ node npm }              # defaults to %w{ node npm yarn }
# append :asdf_map_ruby_bins, 'puma', 'pumactl'

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v13.12.0'
set :nvm_map_bins, %w[node npm which]

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock" # accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false
