	# Make sure there is 1 command line argument
	if [[ $# != 1 ]]; then
    	die
	fi

	SERVER_DOMAIN=$1

	echo "Adding Virtual Host" $SERVER_DOMAIN

	echo "creating directory /var/www/"$SERVER_DOMAIN"/public"
	sudo mkdir /var/www/$1
	sudo mkdir /var/www/$1/public
	sudo chmod -R 777 /var/www/$1
	echo "It Works" > /var/www/$1/public/index.html

	sudo sh -c 'echo "<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	ServerName '${SERVER_DOMAIN}'
	ServerAlias www.'${SERVER_DOMAIN}'

	DocumentRoot /var/www/'${SERVER_DOMAIN}'/public
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog ${APACHE_LOG_DIR}/access.log combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>" > /etc/apache2/sites-available/'${SERVER_DOMAIN}

	echo "Restarting Apache"
	sudo service apache2 restart



