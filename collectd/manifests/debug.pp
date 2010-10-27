#
# Class: collectd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class collectd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require collectd::params
    include puppet::params

    file { "puppet_debug_variables_collectd":
        path    => "${puppet::params::debugdir}/variables/collectd",
        mode    => "${collectd::params::configfile_mode}",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("collectd/variables_collectd.erb"),
    }

}
