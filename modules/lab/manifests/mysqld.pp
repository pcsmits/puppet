class lab::mysqld {
	include lab::mysqld::install, lab::mysqld::config, lab::mysqld::service
}

class lab::mysqld::install {
	Package {ensure => "installed"}
	# installed in base now [use this for package you don't wan't on servers]
	#package {"mariadb":}
	#package {"mariadb-libs":}
	#package {"mariadb-devel":}
	#package {"mariadb-galera-server":}
}

class lab::mysqld::config {
	file { "/etc/my.cnf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/lab/my.cnf",
		notify => Class["mysqld::service"],
	}
}

class lab::mysqld::service {
	service {"mariadb":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

#Class["lab::mysqld::install"] -> Class["lab::mysqld::config"] -> Class["lab::mysqld::service"]
