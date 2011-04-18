#
# Class: portmap::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class portmap::debug {

    # Load the variables used in this module. Check the params.pp file 
    require portmap::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_portmap":
        path    => "${puppet::params::debugdir}/variables/portmap",
        mode    => "${portmap::params::configfile_mode}",
        owner   => "${portmap::params::configfile_owner}",
        group   => "${portmap::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("portmap/variables_portmap.erb"),
    }

}
