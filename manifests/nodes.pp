include base
# Puppet server
node 'puppet' {
	include server
}
node 'bcap' {
	include lab
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
