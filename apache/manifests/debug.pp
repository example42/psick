#
# Class: apache::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class apache::debug {

    # Load the variables used in this module. Check the params.pp file 
    require apache::params
    include puppet::params

    file { "puppet_debug_variables_apache":
        path    => "${puppet::params::debugdir}/variables/apache",
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("apache/variables_apache.erb"),
    }

}
