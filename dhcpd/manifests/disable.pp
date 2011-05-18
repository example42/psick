# Class: dhcpd::disable
#
# Stops dhcpd service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use dhcpd::absent to remove everything
#
# Usage:
# include dhcpd::disable
#
class dhcpd::disable {

    require dhcpd::params

    package { "dhcpd":
        name   => "${dhcpd::params::packagename}",
        ensure => present,
    }

    service { "dhcpd":
        name       => "${dhcpd::params::servicename}",
        ensure     => "stopped" ,
        enable     => "false",
        require    => Package["dhcpd"],
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include dhcpd::monitor::absent }
    # if $backup == "yes" { include dhcpd::backup::absent }
    # if $firewall == "yes" { include dhcpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dhcpd::debug }

}
