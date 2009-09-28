class hosts {

	file {	
             	"hosts":
			mode => 644, owner => root, group => root,
			ensure => present,
			path => $os ?{
                        	default => "/etc/hosts",
                        },
                        ensure => present,
	}
}

