include_recipe "php"
include_recipe "n98-magerun"

node['php']['magento']['package'].each do |pkg|
  package pkg do
    action :install
  end
end

package "php5-suhosin" do
	action :purge
end

package 'libapache2-mod-php5'

#We need git for deployments
package "git-core" do
  action :install
end

if node['php']['install_apache2_module_config']
  directory "/etc/php5/apache2" do
    owner "root"
    group "root"
    mode 00644
    action :create
  end

  template "/etc/php5/apache2/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(:directives => node['php']['directives'])
    notifies :restart, 'service[apache2]'
  end
end

# Install Magento cron
cron_filepath = "#{node['magento']['docroot']}/cron.sh"

cron "Magento cron.sh" do
  minute "*/5"
  command cron_filepath
  user "#{node['magento']['web_user']}"
end

file cron_filepath do
  only_if do File.exists?(cron_filepath) end
  mode "755"
end
