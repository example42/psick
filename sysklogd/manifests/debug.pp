#
# Class: sysklogd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class sysklogd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require sysklogd::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_sysklogd":
        path    => "${puppet::params::debugdir}/variables/sysklogd",
        mode    => "${sysklogd::params::configfile_mode}",
        owner   => "${sysklogd::params::configfile_owner}",
        group   => "${sysklogd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("sysklogd/variables_sysklogd.erb"),
    }

}
