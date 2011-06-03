#
# Class: postgresql::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class postgresql::debug {

    # Load the variables used in this module. Check the params.pp file 
    require postgresql::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_postgresql":
        path    => "${puppet::params::debugdir}/variables/postgresql",
        mode    => "${postgresql::params::configfile_mode}",
        owner   => "${postgresql::params::configfile_owner}",
        group   => "${postgresql::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("postgresql/debug.erb"),
    }

}
