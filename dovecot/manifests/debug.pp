#
# Class: dovecot::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class dovecot::debug {

    # Load the variables used in this module. Check the params.pp file 
    require dovecot::params
    include puppet::params

    file { "puppet_debug_variables_dovecot":
        path    => "${puppet::params::debugdir}/variables/dovecot",
        mode    => "${dovecot::params::configfile_mode}",
        owner   => "${dovecot::params::configfile_owner}",
        group   => "${dovecot::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("dovecot/variables_dovecot.erb"),
    }

}
