class php {
	include php::install, php::config, php::service
}

class php::install {
	Package {ensure => "installed"}
	package {'php-pear*':}
}

class php::config {
	file { "/etc/php.ini":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet:///modules/php/files/php.ini",
		notify => Class["php::service"],
	}
}

class php::service {
	service {"httpd":
		ensure => running,
		hassstatus => true,
		hasrestart => true,
		enable => true,
	}
}

Class["php::install"] -> Class["php::config"] -> Class["php::service"]
