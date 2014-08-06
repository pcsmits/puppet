#!/usr/bin/perl -w
use strict;

use Getopt::Long;
my $node;
my $ip;
my $user;
my $help;

GetOptions ("hostname=s" => \$node,    # numeric
              "ip=s"   => \$ip,      # string
              "user=s"  => \$user,
		"help" => \$help)   # flag
  or die("Error in command line arguments\n");

if($help||(!$ip&&!$user&&!$node)){
	
	print <<BLOCK;
		usage:
		./newPuppet.pl --hostname=newhostname --ip=newip --user=newuser
		./newPuppet.pl --help 
			displays this message
		./newPuppet.pl --user=newuser
			only adds new user
		./new Puppet.pl --hsotname=newhsostname --ip=newip
			only add new machien
BLOCK
	die;
}

#add new node to /etc/puppet/manifests/nodes.pp
if($node || $ip){
	if($node && $ip){
		print "Adding new Host $node with IP: $ip\n";
		my $nodeBlock = <<BLOCK;
node "$node" {
       include lab
}

BLOCK
		my $hostBlock = <<BLOCK;
host { "$node":
    ip => $ip,
}

BLOCK
		open(NODE, '>>', '/etc/puppet/manifests/nodes.pp') or die "Couldn't opend nodes";
		print NODE $nodeBlock;
		close(NODE);

		open(HOST, '>>', '/etc/puppet/modules/hosts/manifests/init.pp') or die "Couldn't opend hosts";
		print HOST $hostBlock;
		close(HOST);
	} else {
		print "Must include both --hostname and --ip";
		die;
	}
}

# add new user
if ($user){
	print "Adding new user $user\n";
	my $userBlock= <<BLOCK;
	group {"$user":ensure => present,}

	user {"$user":
		home => "/home/$user",
		ensure => 'present',
		gid => "$user",
		groups => 'wheel',
		managehome => true,
		require => Group["$user"],
	}

BLOCK

	open(USER, '>>', '/etc/puppet/modules/users/manifests/default.pp') or die "Couldn't opend users";
	print USER $userBlock;
	close(USER);
}

print "Updating puppet\n";
system('puppet apply /etc/puppet/manifests/site.pp')){
my $error = $? >> 8;

######################################################
print "Signing Certificates\n";
system("puppet cert list $node");
$error = $? >> 8;
if(!$error){
	system("puppet cert sign $node");
}else {
	print "No cert for $node found, run puppet agent:\n\t #~ puppet agent --server puppet --waitforcert 60 --test"
}

chdir "/etc/puppet/";
if($error){
	print "Reverting Files\n";
	system("git reset --hard");
} else {
	print "Puppet Updated\n";
	system("git commit -m 'Puppet Autocommit all files' -a"
}
