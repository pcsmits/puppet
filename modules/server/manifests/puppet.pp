class server::puppet {
  file { "/etc/puppet/puppet.conf":
    owner  => 0, group  => 0, mode => 0644,
  }

  file { "/opt/sbbrg-scripts":
	ensure => directory,
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => 'puppet://puppet/modules/server/sbbrg-scripts',
        recurse => remote,
    }

#  service { "puppet":
#    name       => "puppet",
#    ensure     => running,
#    enable     => true, hasstatus  => true, hasrestart => true,
#    require    => File["/etc/puppet/puppet.conf"]
#  }
}

