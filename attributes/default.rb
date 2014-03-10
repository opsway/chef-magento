case node['platform']
when "centos", "redhat", "fedora"
	default['php']['magento']['package'] = []
when "debian", "ubuntu"
	default['php']['magento']['package'] = ["php5-xmlrpc","php5-mcrypt","php5-mhash","php5-gd","php5-mysql","php5-curl","php5-memcache"]
	override['php']['packages']      	 = ['php5', 'php5-cli', 'php-pear']
	default['magento']['web_user'] 		 = "www-data"
else
	default['php']['magento']['package'] = []
end

default['magento']['docroot'] 			 = "/var/www/current"

default['magento']['supportuser'] = {
	'username' => 'supportadmin',
	'email'	   => 'support@opsway.com',
	'role'	   => 'Administrators'
}

default['php']['install_apache2_module_config'] = true
