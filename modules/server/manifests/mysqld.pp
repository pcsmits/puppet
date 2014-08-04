class server::mysqld {
	include server::mysqld::install, server::mysqld::config, server::mysqld::service
}

class server::mysqld::install {
	Package {ensure => "installed"}
	# installed in base now [use this for package you don't wan't on servers]
	#package {"mariadb":}
	#package {"mariadb-libs":}
	#package {"mariadb-devel":}
	#package {"mariadb-galera-server":}
}

class server::mysqld::config {
	file { "/etc/my.cnf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/server/my.cnf",
		notify => Class["mysqld::service"],
	}
}

class server::mysqld::service {
	service {"mariadb":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

Class["server::mysqld::install"] -> Class["server::mysqld::config"] -> Class["server::mysqld::service"]
