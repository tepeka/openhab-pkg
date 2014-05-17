openhab deb package
=======

This package installs openhab with a init script and debian like configuraiton.
It is hosted on the lxccu repostory and it was created because of my friend [tepeka](https://github.com/tepeka)

## How to install
```
# install lxccu repo
wget -O ./lxccu-repo.deb http://www.lxccu.com/latest-repo.php
dpkg -i ./lxccu-repo.deb
apt-get update

# install openhab
apt-get install openhab
```
## Install without repository

## Requirements
You need the [fpm](https://rubygems.org/gems/fpm) ruby cli tool to build the package by our own.

## Build and install package
```
git clone https://github.com/bullshit/openhab-deb.git
cd openhab-deb
bash build.sh
dpkg -i openhab_*.deb
```
# How to use

The base directory is /opt/openhab. You use the configurations and addons folder as you know. The folder etc is a symlink to /etc/openhab. Logs are stored under /var/log/openhab. The init script starts the process as user openhab.

## Daemon Configuration
```
HTTPPORT=8080
HTTPSPORT=8443
TELNETPORT=5555
AUTHENTICATION=0
```
You can set the ports in the /etc/default/openhab file. If you use authentication just change the AUTHENTICATION var to 1 and add some user credentials to /etc/openhab/users.cfg.
After installation add the openhab daemon to start on boot
```
insserv openhab
```

## How to start the daemon on port 80

### Proxy
You can use nginx as a proxy server with this configuration from [jpmens](https://gist.github.com/jpmens/8027912) 
```
worker_processes  1;
 
error_log   error.log debug;
 
pid        nginx.pid;
 
# for debugging
daemon off;
 
events {
    worker_connections  128;
}
 
http {
	server {
		listen 0.0.0.0:80;
		server_name openhab;
 
		ssl on;
		ssl_certificate server.crt;
		ssl_certificate_key server.key;
		ssl_session_cache shared:SSL:10m;
 
		location / {
			# Convert inbound WAN requests for https:// to
			# LAN requests for https://..:8443 for openHAB
			proxy_pass https://127.0.0.1:8443/;
			proxy_set_header Host $host:$server_port;
 
                        # FIXME: keepalive needs tuning (e.g. HABdroid & openHAB/iOS don't see eachothers switches move)
		}
	}
}
```
and add a Host Entry into /etc/openhab/jetty.xml like this
```
<Set name="Host">127.0.0.1</Set>
```

### Iptables

or you set iptables rule
```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
```

