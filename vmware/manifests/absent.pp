# Class: vmware::absent
#
# Removes vmware package and its relevant monitor, backup, firewall entries
#
# Usage:
# include vmware::absent
#
class vmware::absent {

    require vmware::params

    package { "vmware":
        name   => "${vmware::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vmware::monitor::absent }
#    if $backup == "yes" { include vmware::backup::absent }
#    if $firewall == "yes" { include vmware::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vmware::debug }

}
