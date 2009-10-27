class apache {

	package { apache:
		name   => $operatingsystem ? {
			debian	=> "apache2",
			default	=> "httpd",
			},
		ensure => present,
	}

	service { apache:
		name => $operatingsystem ? {
                        debian  => "apache2",
                        default => "httpd",
                        },
		ensure => running,
		enable => true,
		pattern => $operatingsystem ? {
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
			mode => 644, owner => root, group => root,
			require => Package[apache],
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/httpd/conf/httpd.conf",
                        },
	}
}

class apache::modsecurity inherits apache {

	package { mod_security:
		name   => $operatingsystem ? {
			default	=> "mod_security",
			},
		ensure => present,
	}
}

class apache::php  {

	include apache 

        package { php:
                name => $operatingsystem ? {
                        default => "php",
                        },
                ensure => present,
        }

        package { php-common:
                name => $operatingsystem ? {
                        default => "php-common",
                        },
                ensure => present,
        }
}

define php::module {
        package { "php-${name}":
                name => $operatingsystem ? {
                        default => "php-${name}",
                        },
                ensure => present,
        }
}


define php::pear {
        package { "php-pear-${name}":
                name => $operatingsystem ? {
                        default => "php-pear-${name}",
                        },
                ensure => present,
        }
}

