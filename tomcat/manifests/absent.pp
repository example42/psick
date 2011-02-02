# Class: tomcat::absent
#
# Removes tomcat package and its relevant monitor, backup, firewall entries
#
# Usage:
# include tomcat::absent
#
class tomcat::absent {

    require tomcat::params

    package { "tomcat":
        name   => "${tomcat::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include tomcat::monitor::absent }
    if $backup == "yes" { include tomcat::backup::absent }
    if $firewall == "yes" { include tomcat::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include tomcat::debug }

}
