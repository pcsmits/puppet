class server::bcap {
    include server::httpd
    include server::mysqld
        
    if $hostname =~ /-dev$/ {
        notice("Copying dev files")
        $filepath = "server/bcap/bcap-dev/"
    } else {
        $filepath = "server/bcap/bcap/"
    }	
}
