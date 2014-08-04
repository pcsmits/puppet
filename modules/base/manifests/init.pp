class base {
  include users::default 
  include hosts

  exec { "disable selinux on $hostname":
          user    => "root",
          command => "/usr/sbin/setenforce 0",
          unless  => "/usr/sbin/sestatus | /bin/egrep -q '(Current mode:.*permissive|SELinux.*disabled)'";
  }

#  file { "/opt/sbbrg-scripts":
#        ensure => directory,
#        mode => "0644",
#        owner => 'root',
#        group => 'root',
#    }

#  exec { "Running Yum Update on $hostname":
 #         user    => "root",
  #        command => "/usr/sbin/yum -y update",
 # }

  package {
    'vim-enhanced': ensure => 'latest';
    'subversion': ensure => 'latest';
    'screen': ensure => 'latest';
    'htop': ensure => 'latest';
    'postfix': ensure => 'latest';
    'gcc': ensure => 'latest';
  }
  service {"sshd":
	ensure => running,
	hasrestart => true,
	enable => true,
  }

  include base::httpd, base::mysqld
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
        package {"mariadb-galera-server":}
}

