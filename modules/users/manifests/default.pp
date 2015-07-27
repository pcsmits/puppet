class users::default {
  user { 'root':
	ensure => 'present',
	comment => 'root',
	uid => '0',
	gid => '0',
	home => '/root',
    password => '$6$ke0rBNq5$mycLdfEGqWVEft8o3FnfRduDarl280gP9gXWfwBo8Z91v3NcDRDfjRtu9Fy6rHCMXyFcAlHEFXF.zAMBrbH5J0',
	shell => '/bin/bash',
  }

  
  $users = ['psmits','mmiller','nscott','bschmidt','sbbAdmin','myu','nagios']
  define manageUser {

      group { $name : ensure => present,}

      user { $name :
        home => "/home/$name",
        ensure => 'present',
        gid => $name,
        groups => 'wheel',
        managehome => true,
        require => Group[$name],
        notify => Exec[$name],
      }

      $copyHome = file("/etc/puppet/modules/users/files/$name/.bashrc",'/dev/null')
      if($copyHome != '') {
          file { "/home/$name/.bashrc":
            ensure => present,
            owner => "$name",
            group => "$name",
            mode => 755,
            source => "puppet://puppet/modules/users/$name/.bashrc",
            recurse => remote,
            require => User[$name],
          }
      }

      exec { $name :
         user => "root",
         refreshonly => true,
         command => "/usr/bin/echo \"trayU7ad\" | /usr/bin/passwd ${name} --stdin",
      }
  }
  manageUser { $users: }
}


	#password => '$6$Sriaxa75$EHm7MwhlY/n1DwR69h8v/k26p4mOYfPqGzqJkj7H.vbcd1YMb4XS7hyxGe4z96QtHttQt.YoyPA3/1LSkl0GI/',
