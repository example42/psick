#
# Class: powerdns::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class powerdns::debug {

    # Load the variables used in this module. Check the params.pp file 
    require powerdns::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_powerdns":
        path    => "${puppet::params::debugdir}/variables/powerdns",
        mode    => "${powerdns::params::configfile_mode}",
        owner   => "${powerdns::params::configfile_owner}",
        group   => "${powerdns::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("powerdns/variables_powerdns.erb"),
    }

}
