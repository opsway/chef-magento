include_recipe "php"

node['php']['magento']['package'].each do |pkg|
  package pkg do
    action :install
  end
end

package "php5-suhosin" do
	action :purge
end

#We need git for deployments
package "git-core" do
  action :install
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

include_recipe "n98-magerun::modules"
