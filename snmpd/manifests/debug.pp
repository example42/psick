#
# Class: snmpd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class snmpd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require snmpd::params
    include puppet::params

    file { "puppet_debug_variables_snmpd":
        path    => "${puppet::params::debugdir}/variables/snmpd",
        mode    => "${snmpd::params::configfile_mode}",
        owner   => "${snmpd::params::configfile_owner}",
        group   => "${snmpd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("snmpd/variables_snmpd.erb"),
    }

}
