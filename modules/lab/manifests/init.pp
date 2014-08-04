class lab {
  include lab::httpd
  include lab::puppet::agent
  include lab::mysqld
  include lab::base
}

class lab::base {
  #package {
    # google chrome ?
  #}
}
