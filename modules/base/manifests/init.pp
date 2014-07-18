class base {
  include users::default 
  include hosts
  package {
    'vim-enhanced': ensure => 'latest';
    'subversion': ensure => 'latest';
    'screen': ensure => 'latest';
    'htop': ensure => 'latest';
  }
}
