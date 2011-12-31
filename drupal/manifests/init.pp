#
# Class: drupal
#
# Manages drupal.
# Include it to install and run drupal
# It defines package, service, main configuration file.
#
# Usage:
# include drupal
#
class drupal {

    # Load the variables used in this module. Check the params.pp file 
    require drupal::params

    # We need.... php
    require php

    # We use drush for many operations
    include drupal::drush

    # Installation
    case $drupal::params::use_package {
        yes:     { include drupal::package }
        default: { include drupal::install }
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extra modules and themes (customize)
    if "$drupal::params::extra" == "yes" { include drupal::extra }

    # Include extended classes, if 
    if $backup == "yes" { include drupal::backup }
    if $monitor == "yes" { include drupal::monitor }
    if $firewall == "yes" { include drupal::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "drupal::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include drupal::debug }

}
