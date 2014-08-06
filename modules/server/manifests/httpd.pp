class server::httpd {
	include server::httpd::install, server::httpd::config, server::httpd::service
}

class server::httpd::install {
	Package {ensure => "installed"}
	# installed in base now
}

class server::httpd::config {
	file { "/etc/httpd/conf/httpd.conf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/server/httpd.conf",
		notify => Class["server::httpd::service"],
	}
        file { "/etc/php.ini":
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => '600',
                source => "puppet://puppet/modules/server/php.ini",
		notify => Class["server::httpd::service"],
        }
}

class server::httpd::service {
	service {"httpd":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

#Class["server::httpd::install"] -> Class["server::httpd::config"] -> Class["server::httpd::service"]
