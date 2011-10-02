# Class: foo::disable
#
# Stops foo service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use foo::absent to remove everything
#
# Usage:
# include foo::disable
#
class foo::disable {

    require foo::params

    package { "foo":
        name   => "${foo::params::packagename}",
        ensure => present,
    }

    service { "foo":
        name       => "${foo::params::servicename}",
        ensure     => "stopped" ,
        enable     => "false",
        hasstatus  => "${foo::params::hasstatus}",
        pattern    => "${foo::params::processname}",
        require    => Package["foo"],
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include foo::monitor::absent }
    # if $backup == "yes" { include foo::backup::absent }
    # if $firewall == "yes" { include foo::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include foo::debug }

}
