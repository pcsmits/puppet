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

  group => [{'sbbAdmin': ensure => 'present'}, 'sudo']

  user {'sbbAdmin':
    home => '/home/sbbAdmin',
    ensure => 'present',
    gid => 'sbbAdmin',
    groups => 'wheel',
    comment => 'SBB Admin',
    password => '$6$Sriaxa75$EHm7MwhlY/n1DwR69h8v/k26p4mOYfPqGzqJkj7H.vbcd1YMb4XS7hyxGe4z96QtHttQt.YoyPA3/1LSkl0GI/',
    require => Group['sbbAdmin'],
  }

#  ssh_authorized_key {'psmits':
#    ensure => 'present',
#    type => 'ssh-rsa',
#    key => 'AAAAB3NzaC1yc2EAAAABIwAAAIEA4lkBZSffWOkC1CG69WlhyMjKGTdKyria/ttjjEe1ONd5AgB9x24UhMQ698x19TK4BA/Swmr0UZ0PvjSMBKJv+mZAvulCHtsUn+aZbKkSDFcMYJZn5ZovZHgQHDvv0Flx5ZW8/zj9FDujktCrxcwwZfcMhfJGcORjVpRtUA7+06U=',
#    user => 'psmits',
#    require => User['psmits'],
#  }
}
