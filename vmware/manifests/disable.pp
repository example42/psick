# Class: vmware::disable
#
# Stops vmware service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use vmware::absent to remove everything
#
# Usage:
# include vmware::disable
#
class vmware::disable {

    require vmware::params

    package { "vmware":
        name   => "${vmware::params::packagename}",
        ensure => present,
    }

    service { "vmware":
        name       => "${vmware::params::servicename}",
        ensure     => "stopped" ,
        enable     => "false",
        require    => Package["vmware"],
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vmware::monitor::absent }
    # if $backup == "yes" { include vmware::backup::absent }
    # if $firewall == "yes" { include vmware::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vmware::debug }

}
