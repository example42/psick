# Class: drupal::disable
#
# Stops drupal service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use drupal::absent to remove everything
#
# Usage:
# include drupal::disable
#
class drupal::disable inherits drupal {

    require drupal::params

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include drupal::monitor::absent }
    # if $backup == "yes" { include drupal::backup::absent }
    # if $firewall == "yes" { include drupal::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include drupal::debug }

}
