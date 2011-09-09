#
# Class: jboss::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class jboss::debug {

    # Load the variables used in this module. Check the params.pp file 
    require jboss::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_jboss":
        path    => "${puppet::params::debugdir}/variables/jboss",
        mode    => "${jboss::params::configfile_mode}",
        owner   => "${jboss::params::configfile_owner}",
        group   => "${jboss::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("jboss/variables_jboss.erb"),
    }

}
