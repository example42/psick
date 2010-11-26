#
# Class: rsyslog::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class rsyslog::debug {

    # Load the variables used in this module. Check the params.pp file 
    require rsyslog::params
    include puppet::params

    file { "puppet_debug_variables_rsyslog":
        path    => "${puppet::params::debugdir}/variables/rsyslog",
        mode    => "${rsyslog::params::configfile_mode}",
        owner   => "${rsyslog::params::configfile_owner}",
        group   => "${rsyslog::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("rsyslog/variables_rsyslog.erb"),
    }

}
