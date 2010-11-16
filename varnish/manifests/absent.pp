# Class: varnish::absent
#
# Removes varnish package and its relevant monitor, backup, firewall entries
#
# Usage:
# include varnish::absent
#
class varnish::absent {

    require varnish::params

    package { "varnish":
        name   => "${varnish::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include varnish::monitor::absent }
    if $backup == "yes" { include varnish::backup::absent }
    if $firewall == "yes" { include varnish::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include varnish::debug }


}
