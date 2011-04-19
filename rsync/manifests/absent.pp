# Class: rsync::absent
#
# Removes rsync package and its relevant monitor, backup, firewall entries
#
# Usage:
# include rsync::absent
#
class rsync::absent {

    require rsync::params

    package { "rsync":
        name   => "${rsync::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include rsync::monitor::absent }
    if $backup == "yes" { include rsync::backup::absent }
    if $firewall == "yes" { include rsync::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsync::debug }

}
