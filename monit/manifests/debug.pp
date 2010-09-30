#
# Class: monit::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class monit::debug {

    # Load the variables used in this module. Check the params.pp file 
    require monit::params
    include puppet::params

    file { "puppet_debug_variables_monit":
        path    => "${puppet::params::debugdir}/variables/monit",
        mode    => "${monit::params::configfile_mode}",
        owner   => "${monit::params::configfile_owner}",
        group   => "${monit::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("monit/variables_monit.erb"),
    }

}
