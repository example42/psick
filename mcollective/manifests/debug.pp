#
# Class: mcollective::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class mcollective::debug {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective::params
    include puppet::params

    file { "puppet_debug_variables_mcollective":
        path    => "${puppet::params::debugdir}/variables/mcollective",
        mode    => "${mcollective::params::configfile_mode}",
        owner   => "${mcollective::params::configfile_owner}",
        group   => "${mcollective::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("mcollective/variables_mcollective.erb"),
    }

}
