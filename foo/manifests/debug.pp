#
# Class: foo::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class foo::debug {

    # Load the variables used in this module. Check the params.pp file 
    require foo::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_foo":
        path    => "${puppet::params::debugdir}/variables/foo",
        mode    => "${foo::params::configfile_mode}",
        owner   => "${foo::params::configfile_owner}",
        group   => "${foo::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("foo/variables_foo.erb"),
    }

}
