#
# Class: dashboard::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class dashboard::debug {

    # Load the variables used in this module. Check the params.pp file 
    require dashboard::params
    include puppet::params

    file { "puppet_debug_variables_dashboard":
        path    => "${puppet::params::debugdir}/variables/dashboard",
        mode    => "${dashboard::params::configfile_mode}",
        owner   => "${dashboard::params::configfile_owner}",
        group   => "${dashboard::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("dashboard/variables_dashboard.erb"),
    }

}
