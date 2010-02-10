class apache::php  {

	include apache 

        package { php:
                name => $operatingsystem ? {
                        ubuntu  => "php5",
                        debian  => "php5",
                        default => "php",
                        },
                ensure => present,
        }

        package { php-common:
                name => $operatingsystem ? {
                        ubuntu  => "php5-common",
                        debian  => "php5-common",
                        default => "php-common",
                        },
                ensure => present,
        }
}

define php::module {
        package { "php-${name}":
                name => $operatingsystem ? {
                        ubuntu  => "php5-${name}",
                        debian  => "php5-${name}",
                        default => "php-${name}",
                        },
                ensure => present,
                notify => Service["apache"],
        }
}


define php::pear {
        package { "php-pear-${name}":
                name => $operatingsystem ? {
                        redhat  => "php-pear-${name}",
                        centos  => "php-pear-${name}",
                        },
                ensure => present,
        }
}

