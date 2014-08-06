class base {
  include hosts
  include base::packages
  include base::commands
  include base::services
  include base::files
  include base::httpd 
  include base::mysqld
  include base::agent
}


######

class base::commands {
  exec { "disable selinux on $hostname":
          user    => "root",
          command => "/usr/sbin/setenforce 0",
          unless  => "/usr/sbin/sestatus | /bin/egrep -q '(Current mode:.*permissive|SELinux.*disabled)'";
  }
}

class base::packages {
  package {
    'vim-enhanced': ensure => 'latest';
    'subversion': ensure => 'latest';
    'screen': ensure => 'latest';
    'htop': ensure => 'latest';
    'postfix': ensure => 'latest';
    'gcc': ensure => 'latest';
    #'syslog-ng': ensure => 'latest';
  }
}

class base::services {
  service {"sshd":
	ensure => running,
	hasrestart => true,
	enable => true,
  }
}

class base::files {

  file {"/opt/cron/":
        ensure => directory,
        mode => "0744",
        owner => 'root',
        group => 'root',
        source => 'puppet://puppet/modules/base/cron',
        recurse => remote,
    }

  # cron job to ensure puppet is running
  file { "puppet.cron":
      path    => "/etc/cron.d/puppet.cron",
      ensure  => present,
      owner   => "root",
      group   => "root",
      mode    => 0644,
      content => "1,16,31,46 * * * * root /opt/cron/puppet.cron\n";
  }
}
  
class base::httpd {
    Package {ensure => "installed"}
    package {"httpd":}
    package {"php":}
    package {"php-devel":}
    package {"php-pear":}
}

class base::mysqld {
	Package {ensure => "installed"}
        package {"mariadb":}
        package {"mariadb-libs":}
        package {"mariadb-devel":}
       # package {"mariadb-server":}
}
