#
# Class: squid::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class squid::debug {

    # Load the variables used in this module. Check the params.pp file 
    require squid::params
    include puppet::params

    file { "puppet_debug_variables_squid":
        path    => "${puppet::params::debugdir}/variables/squid",
        mode    => "${squid::params::configfile_mode}",
        owner   => "${squid::params::configfile_owner}",
        group   => "${squid::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("squid/variables_squid.erb"),
    }

}
