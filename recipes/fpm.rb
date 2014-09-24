# mcrypt module is not activated by default

link "/etc/php5/fpm/conf.d/20-mcrypt.ini" do
	to "/etc/php5/mods-available/mcrypt.ini"
	notifies :reload, 'service[php5-fpm]'
end