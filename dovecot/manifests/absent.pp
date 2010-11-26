# Class: dovecot::absent
#
# Removes dovecot package and its relevant monitor, backup, firewall entries
#
# Usage:
# include dovecot::absent
#
class dovecot::absent {

    require dovecot::params

    package { "dovecot":
        name   => "${dovecot::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include dovecot::monitor::absent }
    if $backup == "yes" { include dovecot::backup::absent }
    if $firewall == "yes" { include dovecot::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dovecot::debug }


}
