include base

# Puppet server
node 'puppet' {
	include server
	include server::puppet
}
node 'bcap' {
	include server::bcap
}
node 'research01' {
	include server
	include server::research
}
#node 'members' {
#	include server::members
#}
#node 'investors' {
#	include server::investors
#}

node 'orderbutler1' {
    include server
    include server::orderbutler
}

node 'orderbutler2' {
    include server
    include server::orderbutler
}

## Lab machines
node 'northbrook12' {
	# Parker
	include lab
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::members
    include lab::investors
}
node 'northbrook33' {
	# Matt
	include lab
    include lab::sbbjava
    include lab::bcap
    include lab::analytics
    include lab::investors
    include lab::members
}
node 'northbrook29' {
	# Neal
	include lab
    include lab::bcap
    include lab::analytics
    include lab::investors
    include lab::members
}
node 'northbrook19' {
	# Brent
	include lab
    #include lab::sbbjava
    include lab::bcap
    include lab::analytics
    include lab::investors
    include lab::members
}
node 'northbrook105' {
	# Esha
	include lab
    include lab::sbbjava
    include lab::bcap
    include lab::analytics
    include lab::investors
    include lab::members
}
node 'northbrook101' {
	include lab::intern
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::investors
}
node 'northbrook102' {
	include lab::intern
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::investors
}
node 'northbrook103' {
	include lab::intern
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::investors
}
node 'northbrook104' {
	include lab::intern
}

node 'northbrook106' {
	include lab::intern
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::investors
}
node 'northbrook107' {
	include lab::intern
    include lab::sbbjava
    include lab::analytics
    include lab::bcap
    include lab::investors
}
