class lab::httpd {
	include lab::httpd::install, lab::httpd::config, lab::httpd::service
}

class lab::httpd::install {
	Package {ensure => "installed"}
	  exec { "pecl install stats on $hostname":
		  user    => "root",
		  command => "/usr/bin/pecl install stats",
		  unless => "/usr/bin/pecl list | grep stats",
	  }

	# installed in base now
	# package {"httpd":}
	# package {"php":}
	# package {"php-pear":}
}

class lab::httpd::config {
	file { "/etc/httpd/conf/httpd.conf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '600',
		source => "puppet://puppet/modules/lab/httpd.conf",
		notify => Class["lab::httpd::service"],
	}
        file { "/etc/php.ini":
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => '600',
                source => "puppet://puppet/modules/lab/php.ini",
		notify => Class["lab::httpd::service"],
        }
}

class lab::httpd::service {
	service {"httpd":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

#Class["lab::httpd::install"] -> Class["lab::httpd::config"] -> Class["lab::httpd::service"]
