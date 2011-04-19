#
# Class: cobbler::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class cobbler::debug {

    # Load the variables used in this module. Check the params.pp file 
    require cobbler::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_cobbler":
        path    => "${puppet::params::debugdir}/variables/cobbler",
        mode    => "${cobbler::params::configfile_mode}",
        owner   => "${cobbler::params::configfile_owner}",
        group   => "${cobbler::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("cobbler/variables_cobbler.erb"),
    }

}
