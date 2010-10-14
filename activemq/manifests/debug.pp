#
# Class: activemq::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class activemq::debug {

    # Load the variables used in this module. Check the params.pp file 
    require activemq::params
    include puppet::params

    file { "puppet_debug_variables_activemq":
        path    => "${puppet::params::debugdir}/variables/activemq",
        mode    => "${activemq::params::configfile_mode}",
        owner   => "${activemq::params::configfile_owner}",
        group   => "${activemq::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("activemq/variables_activemq.erb"),
    }

}
