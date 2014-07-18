class mysqld {
	include mysqld::install, mysqld::config, mysqld::service
}

class mysqld::install {
	Package {ensure => "installed"}
	package {"mariadb":}
	package {"mariadb-libs":}
	package {"mariadb-devel":}
	package {"mariadb-galera-server":}
}

class mysqld::config {
	file { "/etc/my.cnf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/mysqld/my.cnf",
		notify => Class["mysqld::service"],
	}
}

class mysqld::service {
	service {"mariadb":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

Class["mysqld::install"] -> Class["mysqld::config"] -> Class["mysqld::service"]
