#
# Class: powerdns
#
# Manages powerdns.
# Include it to install and run powerdns
# It defines package, service, main configuration file.
#
# Usage:
# include powerdns
#
class powerdns {

    # Load the variables used in this module. Check the params.pp file 
    require powerdns::params

    # Basic Package - Service - Configuration file management
    package { "powerdns":
        name   => "${powerdns::params::packagename}",
        ensure => present,
    }
    package { "powerdns-sql":
        name   => "${powerdns::params::packagename-sql}",
        ensure => present,
    }

    service { "powerdns":
        name       => "${powerdns::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${powerdns::params::hasstatus}",
        pattern    => "${powerdns::params::processname}",
        require    => Package["powerdns"],
        subscribe  => File["powerdns.conf"],
    }
	file { "powerdns.conf":
	        mode => 644, 
			owner => root, 
			group => root,
	        require => Package['powerdns'],
	        ensure => present,
	        path => $operatingsystem ?{
	            default => "/etc/powerdns/pdns.conf",
	        },
			source => [
			            "puppet://$server/powerdns/pdns.conf.$hostname",
			            "puppet://$server/powerdns/pdns.conf"
			        ],
			sourceselect => first
	}
	

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "powerdns::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include powerdns::puppi }
    if $backup == "yes" { include powerdns::backup }
    if $monitor == "yes" { include powerdns::monitor }
    if $firewall == "yes" { include powerdns::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include powerdns::debug }

}
