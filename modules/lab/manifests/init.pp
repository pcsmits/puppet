class lab {
  include users::default
  include lab::base
  include lab::httpd
  include lab::mysqld
  include lab::r
}

class lab::base {
	#Skype, netbeans, google-chrome
	file { "/opt/sbbrg-packages":
        ensure => directory,
        mode => "0744",
        owner => 'root',
        group => 'root',
        source => 'puppet://puppet/modules/lab/sbbrg-packages/',
        recurse => true,
	}
    
    exec {'google-chrome':
        user    => "root",
        command => "/usr/bin/yum -y install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
        unless  => "/usr/bin/test -d /opt/google";
    }
    exec {'skype':
        user    => "root",
        command => "/usr/bin/yum -y install /opt/sbbrg-packages/skype.rpm",
        unless  => "/usr/bin/test -e /usr/bin/skype";
    }
    exec {'netbeans':
        user    => "root",
        command => "/opt/sbbrg-packages/netbeans-8.0.2-linux.sh --silent",
        unless  => "/usr/bin/test -d /usr/local/netbeans-8.0.2";
    }


    ### Creating Skeletons for SVN repos
    exec { "Creating svn directory" :
        user => "root",
             command => "/usr/bin/mkdir /var/www/svn",
             unless => "/usr/bin/test -d /var/www/svn";
    }

    exec { "Creating Repos" :
        user => "root",
             command => "/usr/bin/mkdir /var/www/svn/bcapSoftware /var/www/svn/sbbAnalytics /var/www/svn/sbbClient /var/www/svn/sbbInvestor /var/www/svn/sbbJava",
             unless => "/usr/bin/test -d /var/www/svn/bcapSoftware";
    }

}
