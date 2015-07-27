class base {
  include schedule
  include hosts
  include base::commands

  if $::operatingsystem == 'CentOS' {
    include base::centos
  } else {
    include base::fedora
  }

  include base::packages
  include base::services
  include base::files
  include base::agent
}


######

class base::commands {
  ## Yum update unless already up todate
  exec { "Updating Puppet: This will take 10-30 minutes":
	user => "root",
	command => "/usr/bin/yum update -y",
	unless => "/usr/bin/test -d /opt/cron";
  }

  exec { "Security Patches":
	# Update all Security Patches if any available
	user => "root",
	command => "/usr/bin/yum update -y --exclude=kernel* --security",
	unless => "/usr/bin/yum check-update --security --exclude=kernel* | grep --quiet 'No packages needed'";
  }
  
	
  ## Disabling SELinux
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
    'wget': ensure => 'latest';
    'nano': ensure => 'latest';
    'nagios-plugins-all': ensure => 'present';
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

  file {"/etc/selinux/config":
        ensure => present,
        mode => "0544",
        owner => 'root',
        group => 'root',
        source => 'puppet://puppet/modules/base/etc/selinux/config',
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

class base::centos {
  # repos for 
  package {
    'epel-release': ensure => 'latest';
  }
  exec { "EL Repository":
    user => "root",
    command => "/usr/bin/rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm",
	unless => "/usr/bin/yum -C repolist | /usr/bin/grep -q elrepo";
  }
  exec { "Nux Repository":
    user => "root",
    command => "/usr/bin/rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm",
	unless => "/usr/bin/yum -C repolist | /usr/bin/grep -q nux-dextop";
  }
}
class base::fedora {
}
