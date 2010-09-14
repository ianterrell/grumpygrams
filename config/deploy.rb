require 'bundler/capistrano'

set :application, "grumpygrams"

default_run_options[:pty] = true
set :repository,  "git@github.com:ianterrell/grumpygrams.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
ssh_options[:forward_agent] = true

set :use_sudo,      false

role :app, "grumpygrams.com"
role :web, "grumpygrams.com"
role :db,  "grumpygrams.com", :primary => true

set :user,          'deploy'
set :password,      'grumpdeploy99'

set :keep_releases, 10
set :branch, "master"
set :deploy_to,      "/home/deploy/#{application}"

after "deploy:update_code","deploy:symlink_configs"
after "deploy:update_code","deploy:cleanup"
# after "deploy:update_code","deploy:package_assets"

# =============================================================================
namespace(:deploy) do  
  task :symlink_configs, :roles => :app, :except => {:no_symlink => true} do
    configs = %w{ database }
    configs.map! { |file| "ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml" }
    run <<-CMD
      cd #{release_path} && #{configs.join(' && ')}
    CMD
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Create asset packages for production" 
  task :package_assets, :roles => :app do
    run <<-EOF
     cd #{release_path} && rake asset:packager:build_all RAILS_ENV=production
    EOF
  end
  
  desc "Tail the Rails production log for this environment"
  task :tail_production_logs, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts  # for an extra line break before the host name
      puts "#{channel[:server]} -> #{data}" 
      break if stream == :err    
    end
  end
end
# =============================================================================
namespace :nginx do 
  desc "Start Nginx on the app server."
  task :start, :roles => :app do
    sudo "/etc/init.d/nginx start"
  end

  desc "Restart the Nginx processes on the app server by starting and stopping the cluster."
  task :restart , :roles => :app do
    sudo "/etc/init.d/nginx restart"
  end

  desc "Stop the Nginx processes on the app server."
  task :stop , :roles => :app do
    sudo "/etc/init.d/nginx stop"
  end

  desc "Tail the nginx logs for this environment"
  task :tail, :roles => :app do
    run "tail -f /var/log/engineyard/nginx/vhost.access.log" do |channel, stream, data|
      puts "#{channel[:server]}: #{data}" unless data =~ /^10\.[01]\.0/ # skips lb pull pages
      break if stream == :err    
    end
  end
end