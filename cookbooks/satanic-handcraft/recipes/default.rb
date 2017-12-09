#
# Cookbook:: satanic-handcraft
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'poise-python'

python_runtime 'satanic-handcraft' do
  version '3'
end

directory '/home/ubuntu/.ssh' do
  owner 'ubuntu'
  recursive true
end

cookbook_file '/home/ubuntu/wrap-ssh4git.sh' do
  source 'git_wrap.sh'
  owner 'ubuntu'
  mode '0755'
end

deploy '/opt/satanic-handcraft' do
  repo 'git@github.com:ed-asriyan/satanic-handcraft-3000.git'
  user 'ubuntu'
  branch 'develop'
  action :deploy
  migrate false
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
  ssh_wrapper '/home/ubuntu/wrap-ssh4git.sh'
  scm_provider Chef::Provider::Git
end

python_virtualenv 'satanic-handcraft'

pip_requirements '/opt/satanic-handcraft/current/requirements.txt' do
  virtualenv 'satanic-handcraft'
  python 'satanic-handcraft'
end

tar_extract 'https://clis.ng.bluemix.net/download/bluemix-cli/latest/linux64' do
	target_dir '/opt/bluemix/'
	creates '/opt/bluemix/install'
  	tar_flags [ '-P', '--strip-components 1' ]
end

bash 'install_bluemix' do
  cwd '/opt/bluemix/'
  code <<-EOH
	./install_bluemix_cli
	EOH
end

execute 'install_dev_tools' do
  command 'curl -sL https://ibm.biz/idt-installer | bash'
  live_stream true
  action :run
end
