# Class: sysklogd::absent
#
# Removes sysklogd package and its relevant monitor, backup, firewall entries
#
# Usage:
# include sysklogd::absent
#
class sysklogd::absent {

    require sysklogd::params

    package { "sysklogd":
        name   => "${sysklogd::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include sysklogd::monitor::absent }
    if $backup == "yes" { include sysklogd::backup::absent }
    if $firewall == "yes" { include sysklogd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include sysklogd::debug }

}
