class hosts {
  host {
	#lab machines add all new machines here
	# then add puppet manually on local lab machine
	# install puppet and run puppet
    'localhost': ip => '127.0.0.1',
            host_aliases => ['localhost.localdomain', 'svnBcap','svnInvestor','svnClient','svnAnalytics', 'svnJava'];
    'localhost6': ip => '::1',
            host_aliases => ['localhost6.localdomain6'];
	'northbrook12': ip => '192.168.0.204',
			host_aliases => 'psmits';
	'northbrook4': ip => '192.168.0.222',
			host_aliases => 'acho';
	'northbrook33': ip => '192.168.0.224',
			host_aliases => 'mmiller';
	'northbrook29': ip => '192.168.0.217',
			host_aliases => 'nscott';
	'northbrook19': ip => '192.168.0.216',
			host_aliases => 'bschmidt';
	'northbrook2': ip => '192.168.0.215',
			host_aliases => 'myu';
	'northbrook103': ip => '192.168.0.214',
			host_aliases => 'rlesser';
	'northbrook102': ip => '192.168.0.213',
			host_aliases => 'dvorva';
	'northbrook105': ip => '192.168.0.225',
			host_aliases => 'ewang';
	'northbrook106': ip => '192.168.0.218',
			host_aliases => 'misc';
	'northbrook107': ip => '192.168.0.231',
			host_aliases => 'kfunch';

	# Servers
	'puppet': ip => '192.168.0.207';
	'research': ip => '192.168.0.240';
	'analytics': ip => '192.168.0.203';
	'analyticsDB': ip => '192.168.0.223';
	'members': ip => '192.168.0.241';
	'membersDev': ip => '192.168.0.236';
	'bcap': ip => '192.168.0.249';
	'nagios': ip => '192.168.0.205';
	'sbbrg.com': ip => '192.168.0.210';
	'investors': ip => '192.168.0.206';
	'orderbutler': ip => '192.168.0.252';
	'orderbutler1': ip => '192.168.0.219';
	'orderbutler2': ip => '192.168.0.208';
   }
}

