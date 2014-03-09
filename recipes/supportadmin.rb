include_recipe "n98-magerun"

require 'securerandom'

random_password = SecureRandom.hex

execute "Reset support admin password" do
	command <<-EOF
		/usr/local/bin/n98-magerun.phar --root-dir=#{node['magento']['docroot']} admin:user:create #{node['magento']['supportuser']['username']} #{node['magento']['supportuser']['password']} #{random_password} Support Admin #{node['magento']['supportuser']['role']}
		/usr/local/bin/n98-magerun.phar --root-dir=#{node['magento']['docroot']} admin:user:change-password #{node['magento']['supportuser']['username']} #{random_password}
	EOF
	returns [0,1]
	only_if do File.exist?("/usr/local/bin/n98-magerun.phar") end
end