#
# Class: samba::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class samba::debug {

    # Load the variables used in this module. Check the params.pp file 
    require samba::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_samba":
        path    => "${puppet::params::debugdir}/variables/samba",
        mode    => "${samba::params::configfile_mode}",
        owner   => "${samba::params::configfile_owner}",
        group   => "${samba::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("samba/variables_samba.erb"),
    }

}
