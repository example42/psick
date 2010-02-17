# Define: php::module
#
# Installs the defined php module
#
# Usage:
# php::module { modulename: }
# Example:
# php::module { mysql: }

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


# Define: php::pear
#
# Installs the defined php pear package 

# Note:
# Currently in alpha stage, with installation via rpm
#
# ToDo:
# Real pear managed installation
#
# Usage:
# php::pear { packagename: }
# Example:
# php::module { Crypt-CHAP: }

define php::pear {
        package { "php-pear-${name}":
                name => $operatingsystem ? {
                        redhat  => "php-pear-${name}",
                        centos  => "php-pear-${name}",
                        },
                ensure => present,
        }
}

