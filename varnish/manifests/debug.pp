#
# Class: varnish::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class varnish::debug {

    # Load the variables used in this module. Check the params.pp file 
    require varnish::params
    include puppet::params

    file { "puppet_debug_variables_varnish":
        path    => "${puppet::params::debugdir}/variables/varnish",
        mode    => "${varnish::params::configfile_mode}",
        owner   => "${varnish::params::configfile_owner}",
        group   => "${varnish::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("varnish/variables_varnish.erb"),
    }

}
