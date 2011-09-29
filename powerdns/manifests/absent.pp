# Class: powerdns::absent
#
# Removes powerdns package and its relevant monitor, backup, firewall entries
#
# Usage:
# include powerdns::absent
#

class powerdns::absent {

    require powerdns::params

    package { "powerdns":
        name   => "${powerdns::params::packagename}",
        ensure => absent,
    }
	package { "powerdns-sql":
		name   => "${powerdns::params::packagenamesql}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include powerdns::monitor::absent }
    if $backup == "yes" { include powerdns::backup::absent }
    if $firewall == "yes" { include powerdns::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include powerdns::debug }

}
