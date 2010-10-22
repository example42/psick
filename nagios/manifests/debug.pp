#
# Class: nagios::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class nagios::debug {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params
    include puppet::params

    file { "puppet_debug_variables_nagios":
        path    => "${puppet::params::debugdir}/variables/nagios",
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("nagios/variables_nagios.erb"),
    }

}
