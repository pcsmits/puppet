class puppet::master {
  file { "/etc/puppet/puppet.conf":
    owner  => 0, group  => 0, mode => 0644,
    
  }

  service { "puppet":
    name       => "puppet",
    ensure     => running,
    enable     => true, hasstatus  => true, hasrestart => true,
    require    => File["/etc/puppet/puppet.conf"]
  }
}

