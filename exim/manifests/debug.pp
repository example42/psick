#
# Class: exim::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class exim::debug {

    # Load the variables used in this module. Check the params.pp file 
    require exim::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_exim":
        path    => "${puppet::params::debugdir}/variables/exim",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("exim/variables_exim.erb"),
    }

}
