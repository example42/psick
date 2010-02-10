class apache::base  {

	package { apache:
		name   => $operatingsystem ? {
			freebsd	=> "apache20",
			debian	=> "apache2",
			ubuntu	=> "apache2",
			default	=> "httpd",
			},
		ensure => present,
	}

	service { apache:
		name => $operatingsystem ? {
                        ubuntu  => "apache2",
                        debian  => "apache2",
                        default => "httpd",
                        },
		ensure => running,
		enable => true,
		pattern => $operatingsystem ? {
                        ubuntu  => "/usr/sbin/apache2",
                        debian  => "/usr/sbin/apache2",
                        default => "/usr/sbin/httpd",
                        },
		hasrestart => true,
		hasstatus => true,
		require => Package["apache"],
                subscribe => File["httpd.conf"],
	}

	file {	
             	"httpd.conf":
#			mode => 644, owner => root, group => root,
			require => Package[apache],
			ensure => present,
			path => $operatingsystem ?{
                        	freebsd => "/usr/local/etc/apache20/httpd.conf",
                        	ubuntu  => "/etc/apache2/apache2.conf",
                        	debian  => "/etc/apache2/apache2.conf",
                        	default => "/etc/httpd/conf/httpd.conf",
                        },
	}
}

