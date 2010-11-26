#
# Class: munin::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class munin::debug {

    # Load the variables used in this module. Check the params.pp file 
    require munin::params
    include puppet::params

    file { "puppet_debug_variables_munin":
        path    => "${puppet::params::debugdir}/variables/munin",
        mode    => "${munin::params::configfile_mode}",
        owner   => "${munin::params::configfile_owner}",
        group   => "${munin::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("munin/variables_munin.erb"),
    }

}
