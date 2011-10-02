#
# Class: tomcat
#
# Manages tomcat.
# Include it to install and run tomcat
# It defines package, service, main configuration file.
#
# Usage:
# include tomcat
#
class tomcat {

    # Load the variables used in this module. Check the params.pp file 
    require tomcat::params

    # Basic Package - Service - Configuration file management
    package { "tomcat":
        name   => "${tomcat::params::packagename}",
        ensure => present,
    }

    service { "tomcat":
        name       => "${tomcat::params::servicename}",
        require    => Package["tomcat"],
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${tomcat::params::hasstatus}",
        pattern    => "${tomcat::params::processname}",
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include tomcat::puppi }
    if $backup == "yes" { include tomcat::backup }
    if $monitor == "yes" { include tomcat::monitor }
    if $firewall == "yes" { include tomcat::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in tomcat module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::tomcat" }
            default: { include "tomcat::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include tomcat::debug }

}
