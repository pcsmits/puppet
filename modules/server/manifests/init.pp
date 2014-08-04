class server {
  include server::httpd
  include server::puppetmaster
  include server::mysqld

  # if puppet  run server::puppet::master
  # if bcap run server::bcap
}
