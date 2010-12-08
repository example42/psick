# Class: zip
#
# Manages zip.
# Include it to install zip and unzip
#
# Usage:
# include zip
#
class zip {

    # Load the variables used in this module. Check the params.pp file
    require zip::params

     # Package installation. zip it's really simple package so, install only
    package { zip:
        name   => "${zip::params::packagename}",
        ensure => present,
    }
    package { unzip:
        name   => "${zip::params::packagenameunzip}",
        ensure => present,
    }
}
