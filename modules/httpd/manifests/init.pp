class httpd {
	include httpd::install, httpd::config, httpd::service
}

class httpd::install {
	Package {ensure => "installed"}
	package {"httpd":}
}

class httpd::config {
	file { "/etc/httpd/conf/httpd.conf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/httpd/httpd.conf",
		notify => Class["httpd::service"],
	}
        file { "/etc/php.ini":
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => '600',
                source => "puppet://puppet/modules/httpd/php.ini",
        }
}

class httpd::service {
	service {"httpd":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

Class["httpd::install"] -> Class["httpd::config"] -> Class["httpd::service"]
