class hosts {
  host {
	#lab machines add all new machines here
	# then add puppet manually on local lab machine
	# install puppet and run puppet
	'northbrook12': ip => '192.168.0.119',
			host_aliases => 'psmits';
	'northbrook23': ip => '192.168.0.123',
			host_aliases => 'jsamson';
	'northbrook98': ip => '192.168.0.95',
			host_aliases => 'mmasia';
	'northbrook1': ip => '192.168.0.201',
			host_aliases => 'snavalgund';
	'northbrook2': ip => '192.168.0.220',
			host_aliases => 'myu';
	'northbrook20': ip => '192.168.0.44',
			host_aliases => 'bschmidtt';

	# Servers
	'puppet': ip => '192.168.0.39';
	'bcap': ip => '192.168.0.76';
   }
}
