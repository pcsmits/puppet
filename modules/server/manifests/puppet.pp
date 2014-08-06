class server::puppet {

  # If dev five file path for dev 
  if $hostname =~ /-dev$/ {
      notice("Copying dev files")
      $filepath = "server/puppet/puppet-dev/"
  } else {
      $filepath = "server/puppet/puppet/"
  }

  file { "/etc/puppet/puppet.conf":
    owner  => 0, group  => 0, mode => 0644,
  }

  # directory of convient scripts we want on the puppet server
  file { "/opt/sbbrg-scripts":
	ensure => directory,
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => "puppet://puppet/modules/${filepath}sbbrg-scripts",
        recurse => remote,
  }

  # cron job to ensure puppet master is running
  file {"/opt/cron/puppetmaster.cron":
        ensure => present,
        mode => "0744",
        owner => 'root',
        group => 'root',
        source => "puppet://puppet/modules/${filepath}/cron/puppetmaster.cron",
    }

  file { "puppetmaster.cron":
      path    => "/etc/cron.d/puppetmaster.cron",
      ensure  => present,
      owner   => "root",
      group   => "root",
      mode    => 0644,
      content => "2,17,32,47 * * * * root /opt/cron/puppetmaster.cron\n";
  }

}

