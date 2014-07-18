class hosts {
  host {
	#lab machines add all new machines here
	# then add puppet manually on local lab machine
	# install puppet and run puppet
	'northbrook12': ip => '192.168.0.119',
			host_aliases => 'psmits';
	'northbrook23': ip => '192.168.0.123',
			host_aliases => 'jsamson';

	# Servers
	'puppet': ip => '192.168.0.39';
   }
}
