#
# Class: openldap::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class openldap::debug {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_openldap":
        path    => "${puppet::params::debugdir}/variables/openldap",
        mode    => "${openldap::params::configfile_mode}",
        owner   => "${openldap::params::configfile_owner}",
        group   => "${openldap::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("openldap/variables_openldap.erb"),
    }

}
