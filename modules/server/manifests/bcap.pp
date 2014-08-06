class server::bcap {
    $filepath = ""
    if $hostname =~ /-dev$/ {
   	notice("Copying dev files")
	$filepath = "server/bcap/bcap-dev/"
    } else {
	$filepath = "server/bcap/bcap-dev/"
    }	
}
