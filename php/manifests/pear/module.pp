# Define: php::pear::module
#
# Installs the defined php pear component
#
# Usage:
# php::pear::module { packagename: }
# Example:
# php::pear::module { Crypt-CHAP: }

define php::pear::module {

    include php::pear

    exec { "pear-${name}":
        command => "pear install ${name}",
        unless  => "pear info ${name}",
        require => Package["php-pear"],
    }

}

