set :application, "mine"
set :scm, :git
set :repository,  "https://github.com/frankxgz/guangzhi_amazon.git"
set :scm_passphrase, ""

ssh_options[:keys] = ["MyWebsiteKey.pem"]
set :user, "ec2-user"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

task :production do

	#set :location, "ec2-54-251-246-71.ap-southeast-1.compute.amazonaws.com"
	server "ec2-54-251-246-71.ap-southeast-1.compute.amazonaws.com", :app, :web, :db, :primary => true

	set :deploy_to, "/var/www/mine"

	set :rails_env, :production
	set :current_path, "#{deploy_to}current"
	environment = 'production'

end

after 'deploy', 'set_permissions'
after 'deploy:setup', 'set_permissions'

task :set_permissions do
  sudo "chown ubuntu #{deploy_to}"
  sudo "chmod -R g+w #{deploy_to}"
end

namespace :deploy do
  task :restart do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

 
#server "54.251.246.71", :app, :primary => true


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end