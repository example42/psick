#
# Class: tomcat::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class tomcat::debug {

    # Load the variables used in this module. Check the params.pp file 
    require tomcat::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_tomcat":
        path    => "${puppet::params::debugdir}/variables/tomcat",
        mode    => "${tomcat::params::configfile_mode}",
        owner   => "${tomcat::params::configfile_owner}",
        group   => "${tomcat::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("tomcat/variables_tomcat.erb"),
    }

}
