# Class: lighttpd::absent
#
# Removes lighttpd package and its relevant monitor, backup, firewall entries
#
# Usage:
# include lighttpd::absent
#
class lighttpd::absent {

    require lighttpd::params

    package { "lighttpd":
        name   => "${lighttpd::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include lighttpd::monitor::absent }
    if $backup == "yes" { include lighttpd::backup::absent }
    if $firewall == "yes" { include lighttpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include lighttpd::debug }

}
