#
# Class: postfix::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class postfix::debug {

    # Load the variables used in this module. Check the params.pp file 
    require postfix::params
    include puppet::params

    file { "puppet_debug_variables_postfix":
        path    => "${puppet::params::debugdir}/variables/postfix",
        mode    => "${postfix::params::configfile_mode}",
        owner   => "${postfix::params::configfile_owner}",
        group   => "${postfix::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("postfix/variables_postfix.erb"),
    }

}
