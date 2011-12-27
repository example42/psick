# Class: controltier::server
#
# Manages controltier server installation
# It expectes you have in your repository a package called ctier-server
#
# Usage:
# Automatically included by controltier
#
class controltier::server {

    # Load the variables used in this module. Check the params.pp file
    require controltier::params

    # Basic Package - Service - Configuration file management
    package { "controltier_server":
        name   => "${controltier::params::packagename_server}",
        ensure => present,
    }

    case $operatingsystem {
        default: { }
    }

    if $my_project { include "controltier::${my_project}::server" }

}
