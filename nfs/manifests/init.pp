#
# Class: nfs
#
# Manages nfs.
# Include it to install and run nfs
# It defines package, service, main configuration file.
#
# Usage:
# include nfs::client - For client usage
# include nfs::server - For server usage
#
class nfs {

    # Load the variables used in this module. Check the params.pp file 
    require nfs::params

    # Basic Package - Service - Configuration file management
    package { "nfs":
        name   => "${nfs::params::packagename}",
        ensure => present,
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "nfs::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nfs::debug }

}
