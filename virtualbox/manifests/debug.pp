#
# Class: virtualbox::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class virtualbox::debug {

    # Load the variables used in this module. Check the params.pp file 
    require virtualbox::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_virtualbox":
        path    => "${puppet::params::debugdir}/variables/virtualbox",
        mode    => "${virtualbox::params::configfile_mode}",
        owner   => "${virtualbox::params::configfile_owner}",
        group   => "${virtualbox::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("virtualbox/variables_virtualbox.erb"),
    }

}
