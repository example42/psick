# Class: jboss::absent
#
# Removes jboss package and its relevant monitor, backup, firewall entries
#
# Usage:
# include jboss::absent
#
class jboss::absent {

    require jboss::params

    package { "jboss":
        name   => "${jboss::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include jboss::monitor::absent }
    if $backup == "yes" { include jboss::backup::absent }
    if $firewall == "yes" { include jboss::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include jboss::debug }

}
