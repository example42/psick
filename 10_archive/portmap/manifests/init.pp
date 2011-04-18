# Class: portmap
#
# Manages portmap service 
#
# Usage:
# include portmap
#
class portmap {

    # Load the variables used in this module. Check the params.pp file
    require portmap::params

    # Basic Package 
    package { portmap:
        name   => "${portmap::params::packagename}",
        ensure => present,
    }
    
    service { "portmap":
        name       => "${portmap::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => false,
        require    => Package["portmap"],
    }

    if $backup == "yes" { include portmap::backup }
    if $monitor == "yes" { include portmap::monitor }
    if $firewall == "yes" { include portmap::firewall }

    case $operatingsystem {
        default: { }
    }

}
