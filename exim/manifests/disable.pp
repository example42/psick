# Class: exim::disable
#
# Stops exim service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use exim::absent to remove everything
#
# Usage:
# include exim::disable
#
class exim::disable {

    require exim::params

    package { "exim":
        name   => "${exim::params::packagename}",
        ensure => present,
    }

    service { "exim":
        name       => "${exim::params::servicename}",
        ensure     => "stopped" ,
        enable     => "false",
        hasstatus  => "${exim::params::hasstatus}",
        pattern    => "${exim::params::processname}",
        require    => Package["exim"],
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include exim::monitor::absent }
    # if $backup == "yes" { include exim::backup::absent }
    # if $firewall == "yes" { include exim::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include exim::debug }

}
