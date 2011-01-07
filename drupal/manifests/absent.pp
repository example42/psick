# Class: drupal::absent
#
# Removes drupal package and its relevant monitor, backup, firewall entries
#
# Usage:
# include drupal::absent
#
class drupal::absent {

    require drupal::params

    package { "drupal":
        name   => "${drupal::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include drupal::monitor::absent }
    if $backup == "yes" { include drupal::backup::absent }
    if $firewall == "yes" { include drupal::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include drupal::debug }

}
