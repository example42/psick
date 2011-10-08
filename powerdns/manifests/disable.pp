# Class: powerdns::disable
#
# Stops powerdns service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use powerdns::absent to remove everything
#
# Usage:
# include powerdns::disable
#
class powerdns::disable {

    require powerdns::params

    package { "powerdns":
        name   => "${powerdns::params::packagename}",
        ensure => present,
    }

    service { "powerdns":
        name       => "${powerdns::params::servicename}",
        ensure     => "stopped" ,
        enable     => "false",
        require    => Package["powerdns"],
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include powerdns::monitor::absent }
    # if $backup == "yes" { include powerdns::backup::absent }
    # if $firewall == "yes" { include powerdns::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include powerdns::debug }

}
