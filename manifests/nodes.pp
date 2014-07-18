include base
# Puppet server
node 'puppet' {
	include puppet::master
}

## Lab machines
node 'northbrook12' {
	include puppet::agent
	include httpd
	include mysqld
	include php
}
node 'northbrook23' {
	include puppet::agent
	include httpd
	include mysqld
	include php
}

## mysql web
#node '192.168.0.255' {
#	include httpd
#	include mysqld
#	include php
#}