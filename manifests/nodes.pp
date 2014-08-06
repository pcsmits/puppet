include base

node 'dev' {


}

# Puppet server
node 'puppet' {
	include server
	include server::puppet
}
node 'bcap' {
	include server
	include server::bcap
}

## Lab machines
node 'northbrook12' {
	# Parker
	include lab
}
node 'northbrook98' {
	# Mitch
	include lab
}
node 'northbrook23' {
	# Jake
	include lab
}
node 'northbrook20' {
	#Brent
	include lab
}

#node /^northbrook\d+$/ {
#}

## mysql web
#node '192.168.0.255' {
#	include httpd
#	include mysqld
#	include php
#}
