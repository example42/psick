#
# Class: openvpn::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class openvpn::debug {

    # Load the variables used in this module. Check the params.pp file 
    require openvpn::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_openvpn":
        path    => "${puppet::params::debugdir}/variables/openvpn",
        mode    => "${openvpn::params::configfile_mode}",
        owner   => "${openvpn::params::configfile_owner}",
        group   => "${openvpn::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("openvpn/variables_openvpn.erb"),
    }

}
