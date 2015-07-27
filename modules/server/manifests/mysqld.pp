class server::mysqld {
	include server::mysqld::install 
    include server::mysqld::config
    include server::mysqld::service
    include server::mysqld::schemas
}

class server::mysqld::install {
	Package {ensure => "installed"}
    package {"mariadb":}
    package {"mariadb-libs":}
    package {"mariadb-devel":}
    package {"mariadb-server":}
}

class server::mysqld::config {
    if $::operatingsystem == 'CentOS' {
        file { "/etc/my.cnf":
            ensure => present,
            owner => 'mysql',
            group => 'mysql',
            mode => '644',
            source => "puppet://puppet/modules/server/my.cnf.centos",
            notify => Class["server::mysqld::service"],
        }
    } else {
        file { "/etc/my.cnf":
            ensure => present,
            owner => 'mysql',
            group => 'mysql',
            mode => '644',
            source => "puppet://puppet/modules/server/my.cnf",
            notify => Class["server::mysqld::service"],
        }
    }
}

class server::mysqld::service {
	service {"mariadb":
		ensure => running,
		hasrestart => true,
		enable => true,
	}
}

class server::mysqld::schemas {
    exec { "Set MySQL server root password":
          subscribe => [ Package["mariadb"], Package["mariadb-libs"], Package["mariadb-server"] ],
          refreshonly => true,
          command => "/usr/bin/echo -e \"\nY\ntrayU7ad\ntrayU7ad\nY\nn\nY\nY\n\" | /usr/bin/mysql_secure_installation 2>/dev/null",
          unless => "/usr/bin/mysqladmin -uroot -ptrayU7ad status &> /dev/null",
    }

    $schemas = ['package']
    define manageSchemas {
        exec { $name:
            subscribe => [ Package["mariadb"], Package["mariadb-libs"], Package["mariadb-server"] ],
            #refreshonly => true,
            command => "/usr/bin/mysql -u root -ptrayU7ad -e 'CREATE SCHEMA $name'",
            unless => "/usr/bin/test -d /var/lib/mysql/$name",
        }
    }
    manageSchemas { $schemas: }
}
