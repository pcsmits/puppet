class server {
  include server::httpd
  #include server::puppet
  include server::mysqld

  # if puppet  run server::puppet::master
  # if bcap run server::bcap
}
