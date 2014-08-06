class users::server {
  user { 'root':
	ensure => 'present',
	comment => 'root',
	uid => '0',
	gid => '0',
	home => '/root',
	password => '$6$95s2JM9P$gYNJaK1yGrDDZ.9jXm2NOIjjNDC6qE7XLU88c69TT5qZOHN0.jl/3VWf7Is.GF/ZqSGp2HWzQq8hgWV4lNGX10',
	shell => '/bin/bash',
  }
}
