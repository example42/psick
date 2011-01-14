#
# Class: bind::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class bind::debug {

    # Load the variables used in this module. Check the params.pp file 
    require bind::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_bind":
        path    => "${puppet::params::debugdir}/variables/bind",
        mode    => "${bind::params::configfile_mode}",
        owner   => "${bind::params::configfile_owner}",
        group   => "${bind::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("bind/variables_bind.erb"),
    }

}
