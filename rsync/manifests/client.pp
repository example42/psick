#
# Class: rsync::client
#
# Installs rsync package without managing the service
#
# Usage:
# include rsync::client
#
class rsync::client {

    # Load the variables used in this module. Check the params.pp file 
    require rsync::params

    # Basic Package - Service - Configuration file management
    package { "rsync":
        name   => "${rsync::params::packagename}",
        ensure => present,
    }

}
