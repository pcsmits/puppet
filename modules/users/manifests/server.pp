class users::server {
  user { 'root':
	ensure => 'present',
	comment => 'root',
	uid => '0',
	gid => '0',
	home => '/root',
	password => '$6$Sriaxa75$EHm7MwhlY/n1DwR69h8v/k26p4mOYfPqGzqJkj7H.vbcd1YMb4XS7hyxGe4z96QtHttQt.YoyPA3/1LSkl0GI/',
	shell => '/bin/bash',
  }

  group => [{'psmits': ensure => 'present'}, 'sudo']

  user {'psmits':
    home => '/home/psmits',
    ensure => 'present',
    gid => 'psmits',
    groups => 'wheel',
    comment => 'Parker Smits',
    managehome => true,
    password => '$6$Sriaxa75$EHm7MwhlY/n1DwR69h8v/k26p4mOYfPqGzqJkj7H.vbcd1YMb4XS7hyxGe4z96QtHttQt.YoyPA3/1LSkl0GI/',
    require => Group['psmits'],
  }
  file { '/home/psmits':
	ensure => directory,
	owner => 'psmits',
	group => 'psmits',
	mode => 755,
	source => 'puppet:///modules/users/files/psmits',
	recurse => remote,
	require => User['psmits'],
  }

#  ssh_authorized_key {'psmits':
#    ensure => 'present',
#    type => 'ssh-rsa',
#    key => 'AAAAB3NzaC1yc2EAAAABIwAAAIEA4lkBZSffWOkC1CG69WlhyMjKGTdKyria/ttjjEe1ONd5AgB9x24UhMQ698x19TK4BA/Swmr0UZ0PvjSMBKJv+mZAvulCHtsUn+aZbKkSDFcMYJZn5ZovZHgQHDvv0Flx5ZW8/zj9FDujktCrxcwwZfcMhfJGcORjVpRtUA7+06U=',
#    user => 'psmits',
#    require => User['psmits'],
#  }
}
