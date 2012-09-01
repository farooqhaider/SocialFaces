set :application, "fb_dssd"
set :repository,  "https://203.135.63.150:8443/svn/development/Team2/Sprint4"

set :scm, :subversion
set :scm_verbose, true
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#set :deploy_via, :remote_cache
set :user, "root"
set :deploy_to, "/var/#{application}"
set :deploy_via, :export


set :port, 3344
set :domain, '10.103.97.98'
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

#set :deploy_to, ""
#set :user, ""
set :scm_username, 11030031
set :scm_password, "t231"
set :use_sudo, true
default_run_options[:pty] = true

#ssh_options[:forward_agent] = true

#server "*SERVER IP*", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
