class server::httpd {
	include server::httpd::install, server::httpd::config, server::httpd::service
}

class server::httpd::install {
    Package {ensure => "installed"}
    package {"httpd":}
    package {"php":}
    package {"php-devel":}
    package {"php-gd":}
    package {"php-mysqlnd":}
    package {"php-pdo":}
    package {"php-pear":}
    if $::operatingsystem != 'CentOS' {
        package {"php-gmp":}
    }

    exec { "pecl install stats on $hostname":
        user    => "root",
        command => "/usr/bin/pecl install stats",
        unless => "/usr/bin/pecl list | grep stats",
    }
    exec { "pecl install trader on $hostname":
        user    => "root",
        command => "/usr/bin/pecl install trader",
        unless => "/usr/bin/pecl list | grep trader",
    }
}

class server::httpd::config {
	file { "/etc/httpd/conf/httpd.conf":
        #replace => "no",
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '666',
		source => "puppet://puppet/modules/server/httpd/httpd.conf",
		notify => Class["server::httpd::service"],
	}
    if($clientcert == "research01"){
        file { "/etc/php.ini":
            ensure => present,
            owner => 'root',
            group => 'root',
            mode => '666',
            source => "puppet://puppet/modules/server/httpd/php.ini.research",
            notify => Class["server::httpd::service"],
        }
    } else {
        file { "/etc/php.ini":
            ensure => present,
            owner => 'root',
            group => 'root',
            mode => '666',
            source => "puppet://puppet/modules/server/httpd/php.ini",
            notify => Class["server::httpd::service"],
        }
    }
}

class server::httpd::service {
	service {"httpd":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}
