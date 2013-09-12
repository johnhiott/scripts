	SERVER_DOMAIN=$1

	function createWWW () {
		echo "creating directory /var/www/"$SERVER_DOMAIN"/public"
		sudo mkdir /var/www/$SERVER_DOMAIN
		sudo mkdir /var/www/$SERVER_DOMAIN/public
		sudo chmod -R 777 /var/www/$SERVER_DOMAIN
		echo "It Works" > /var/www/$SERVER_DOMAIN/public/index.html
	}

	function createConfig () {
		echo "Adding Virtual Host" $SERVER_DOMAIN
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
	}

	function showUsage() {
		echo "To create config and www directory: ./vhost.sh mydomain.com"
    	echo "To create config only: ./vhost.sh mydomain.com off"
		exit
	}

	function restartApache() {
		echo "Restarting Apache"
		sudo service apache2 restart
		exit
	}

		
	#if there in only domain in arguements
	if [[ $# == 1 ]]; then
    	createWWW
    	createConfig
    	restartApache
 	fi

	#check second command line arguement
	if [[ $# == 2 ]]; then
		if [[ $2 == "off" ]]; then
			createConfig
			restartApache
		fi
	fi

	showUsage
	



