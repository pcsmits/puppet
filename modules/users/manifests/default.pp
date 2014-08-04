class users::default {
  user { 'root':
	ensure => 'present',
	comment => 'root',
	uid => '0',
	gid => '0',
	home => '/root',
	password => '$6$Sriaxa75$EHm7MwhlY/n1DwR69h8v/k26p4mOYfPqGzqJkj7H.vbcd1YMb4XS7hyxGe4z96QtHttQt.YoyPA3/1LSkl0GI/',
	shell => '/bin/bash',
  }

  group {'psmits':ensure => present,}
  group {'mmasia':ensure => present,}
  group {'jsamson':ensure => present,}

  user {'psmits':
    home => '/home/psmits',
    ensure => 'present',
    gid => 'psmits',
    groups => 'wheel',
    comment => 'Parker Smits',
    managehome => true,
    require => Group['psmits'],
  }
  file { '/home/psmits':
	ensure => directory,
	owner => 'psmits',
	group => 'psmits',
	mode => 755,
	source => 'puppet://puppet/modules/users/psmits',
	recurse => remote,
	require => User['psmits'],
  }

  user {'mmasia':
    home => '/home/mmasia',
    ensure => 'present',
    gid => 'mmasia',
    groups => 'wheel',
    comment => 'Mitch Masia',
    managehome => true,
    require => Group['mmasia'],
  }
  file { '/home/mmasia':
	ensure => directory,
	owner => 'mmasia',
	group => 'mmasia',
	mode => 755,
	source => 'puppet://puppet/modules/users/mmasia',
	recurse => remote,
	require => User['mmasia'],
  }

  user {'jsamson':
    home => '/home/jsamson',
    ensure => 'present',
    gid => 'jsamson',
    groups => 'wheel',
    comment => 'Jake Samson',
    managehome => true,
    require => Group['jsamson'],
  }
  file { '/home/jsamson':
	ensure => directory,
	owner => 'jsamson',
	group => 'jsamson',
	mode => 755,
	source => 'puppet://puppet/modules/users/jsamson',
	recurse => remote,
	require => User['jsamson'],
  }
}
