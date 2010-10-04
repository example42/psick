#
# Class: mysql::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class mysql::debug {

    # Load the variables used in this module. Check the params.pp file 
    require mysql::params
    include puppet::params

    file { "puppet_debug_variables_mysql":
        path    => "${puppet::params::debugdir}/variables/mysql",
        mode    => "${mysql::params::configfile_mode}",
        owner   => "${mysql::params::configfile_owner}",
        group   => "${mysql::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("mysql/variables_mysql.erb"),
    }

}
