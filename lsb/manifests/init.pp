# Class: lsb
#
# Manages lsb.
# Include it to install lsb
#
# Usage:
# include lsb
#
class lsb {

    # Load the variables used in this module. Check the params.pp file
    require lsb::params

     # Package installation. lsb it's really simple package so, install only
    package { lsb:
        name   => "${lsb::params::packagename}",
        ensure => present,
    }
}
