Scripts
===

Scripts for saving time


vhost.sh
----------
* Creates /etc/apache2/sites-available/mydomain.com
* Creates host directory: /var/www/mydomain.com/public

For Creating host directory and config
```sh
./vhost.sh mydomain.com
```

To create config file only
```
./vhost.sh mydomain.com off
```

For now this scripts only allows one parameter: domain name
