# Class: vagrant::absent
#
# Removes vagrant package and its relevant monitor, backup, firewall entries
#
# Usage:
# include vagrant::absent
#
class vagrant::absent {

    require vagrant::params

    package { "vagrant":
        name   => "${vagrant::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vagrant::monitor::absent }
    if $backup == "yes" { include vagrant::backup::absent }
    if $firewall == "yes" { include vagrant::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vagrant::debug }

}
