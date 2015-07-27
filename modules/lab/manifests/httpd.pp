class lab::httpd {
	include lab::httpd::install, lab::httpd::config, lab::httpd::service
}

class lab::httpd::install {
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

class lab::httpd::config {
    if($clientcert == "northbrook33"){
        file { "/etc/httpd/conf/httpd.conf":
            #replace => "no",
            ensure => present,
            owner => 'root',
            group => 'root',
            mode => '666',
            source => "puppet://puppet/modules/lab/httpd.conf.mmiller",
            notify => Class["lab::httpd::service"],
        }
    } else {
        file { "/etc/httpd/conf/httpd.conf":
            #replace => "no",
            ensure => present,
            owner => 'root',
            group => 'root',
            mode => '666',
            source => "puppet://puppet/modules/lab/httpd.conf",
            notify => Class["lab::httpd::service"],
        }
    }
    file { "/etc/php.ini":
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => '666',
        source => "puppet://puppet/modules/lab/php.ini.engr",
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
