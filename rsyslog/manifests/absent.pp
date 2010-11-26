# Class: rsyslog::absent
#
# Removes rsyslog package and its relevant monitor, backup, firewall entries
#
# Usage:
# include rsyslog::absent
#
class rsyslog::absent {

    require rsyslog::params

    package { "rsyslog":
        name   => "${rsyslog::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include rsyslog::monitor::absent }
    if $backup == "yes" { include rsyslog::backup::absent }
    if $firewall == "yes" { include rsyslog::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsyslog::debug }


}
