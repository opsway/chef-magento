package 'libapache2-mod-php5'
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

package "php5-suhosin" do
  action :purge
end