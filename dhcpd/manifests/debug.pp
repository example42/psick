#
# Class: dhcpd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class dhcpd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require dhcpd::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_dhcpd":
        path    => "${puppet::params::debugdir}/variables/dhcpd",
        mode    => "${dhcpd::params::configfile_mode}",
        owner   => "${dhcpd::params::configfile_owner}",
        group   => "${dhcpd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("dhcpd/variables_dhcpd.erb"),
    }

}
