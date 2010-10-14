#
# Class: nrpe::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class nrpe::debug {

    # Load the variables used in this module. Check the params.pp file 
    require nrpe::params
    include puppet::params

    file { "puppet_debug_variables_nrpe":
        path    => "${puppet::params::debugdir}/variables/nrpe",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("nrpe/variables_nrpe.erb"),
    }

}
