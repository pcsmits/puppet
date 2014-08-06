class lab {
  include users::default
  include lab::httpd
  include lab::mysqld
  include lab::base
}

class lab::base {

}
