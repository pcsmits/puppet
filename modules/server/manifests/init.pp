class server {
  include users::server
  include server::httpd
  include server::mysqld
}
