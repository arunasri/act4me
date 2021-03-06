gem 'handy', '>= 0.0.15'
set :stages, %w(staging production)
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
server "173.230.134.171", :app, :web, :db, :primary => true

set :user, 'rails'
set :keep_releases, 7
set :repository, "https://github.com/arunasri/act4me"
set :use_sudo, false
set :scm, :git
set :rvm_type, :user
#set :deploy_via, :copy
set :ssh_options, {:port => 30000}
default_run_options[:pty] = true


set(:application) { "act4me_#{stage}" }
set (:deploy_to) { "/home/#{user}/apps/#{application}" }
set :copy_remote_dir, "/home/#{user}/tmp"

after "deploy:update_code", "app:copy_config_files"

namespace :app do
  desc "copy the app_config_production.yml file"
  task :copy_config_files,:roles => :app do
    run "cp -fv #{deploy_to}/shared/config/database.yml #{release_path}/config"
    run "cp -fv #{deploy_to}/shared/config/app_config.yml #{release_path}/config"
    run "cp -fv #{deploy_to}/shared/config/fog.rb #{release_path}/config/initializers"
  end
end

#config/deploy.rb
task :after_symlink do
  run "ln -nfs #{shared_path}/images/uploads #{release_path}/public/images/uploads"
end


set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
require "handy/capistrano/remote_tasks"
require "handy/capistrano/restart"
require "handy/capistrano/restore_local"
require "handy/capistrano/user_confirmation"
