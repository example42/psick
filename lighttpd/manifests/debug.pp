#
# Class: lighttpd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class lighttpd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require lighttpd::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_lighttpd":
        path    => "${puppet::params::debugdir}/variables/lighttpd",
        mode    => "${lighttpd::params::configfile_mode}",
        owner   => "${lighttpd::params::configfile_owner}",
        group   => "${lighttpd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("lighttpd/variables_lighttpd.erb"),
    }

}
