# Define: php::module
#
# Installs the defined php module
#
# Usage:
# php::module { modulename: }
# Example:
# php::module { mysql: }
#
define php::module {

    include apache::php

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



# Define: php::pear
#
# Installs the defined php pear component
#
# Usage:
# php::pear { packagename: }
# Example:
# php::pear { Crypt-CHAP: }

define php::pear {

    include apache::php::pear

    exec { "pear-${name}":
        command => "pear install ${name}",
        unless  => "pear info ${name}",
        require => Package["php-pear"],
    }

}

