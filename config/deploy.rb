set :application, "mcaems.org"
set :repository,  "git@github.com:rwhitney/highbridge.git"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2'        # Or whatever env you want it to run in.

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, "master"             # deploying from master branch
set :deploy_via, :remote_cache    # without this option deploy does full repository clone

set :user, 'deploy'
set :use_sudo, false
set :deploy_to, "/srv/www/#{application}"

# mcaems.org = 96.126.126.31
role :web, "mcaems.org"                          # Your HTTP server, Apache/etc
role :app, "mcaems.org"                          # This may be the same as your `Web` server
role :db,  "mcaems.org", :primary => true        # This is where Rails migrations will run

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:precompile_assets"
after "deploy:precompile_assets", "deploy:restart"

# Passenger mod_rails uses this stuff:
namespace :deploy do
  task :bundle_gems do
    run "cd #{current_path} && bundle install --deployment --without test development"
  end

  desc "precompile the assets"
  task :precompile_assets, :roles => :web, :except => { :no_release => true } do
    run "cd #{current_path} && rm -rf public/assets/*"
    run "cd #{current_path} && bundle exec rake assets:precompile RAILS_ENV=production"
  end
  
  task :start do ; end
  task :stop do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  namespace :web do
    desc <<-DESC
      Present a maintenance page to visitors. Disables your application's web \
      interface by writing a "maintenance.html" file to each web server. The \
      servers must be configured to detect the presence of this file, and if \
      it is present, always display it instead of performing the request.

      By default, the maintenance page will just say the site is down for \
      "maintenance", and will be back "shortly", but you can customize the \
      page by specifying the REASON and UNTIL environment variables:

        $ cap deploy:web:disable \\
              REASON="a website upgrade" \\
              UNTIL="12pm Central Time"

      Further customization will require that you write your own task.
    DESC
    task :disable, :roles => :web do
      require 'erb'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }

      reason = ENV['REASON']
      deadline = ENV['UNTIL']      
      template = File.read('app/views/admin/maintenance.html.erb')
      page = ERB.new(template).result(binding)

      put page, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end