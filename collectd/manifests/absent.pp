# Class: collectd::absent
#
# Removes collectd package and its relevant monitor, backup, firewall entries
#
# Usage:
# include collectd::absent
#
class collectd::absent {

    require collectd::params

    package { "collectd":
        name   => "${collectd::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include collectd::monitor::absent }
    if $backup == "yes" { include collectd::backup::absent }
    if $firewall == "yes" { include collectd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include collectd::debug }


}
