# Class: nfs
#
# Manages nfs common settings for client and server activities.
#
# Usage:
# include nfs::client - For client usage
# include nfs::server - For server usage
#
class nfs {

    # Load the variables used in this module. Check the params.pp file
    require nfs::params

    # portmapper is need both for client and server usage
    include portmap

    # Basic Package 
    package { nfs:
        name   => "${nfs::params::packagename}",
        ensure => present,
    }

    case $operatingsystem {
        default: { }
    }

}
