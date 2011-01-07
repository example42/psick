#
# Class: drupal::package
#
# Installs Drupal using the OS official package
#
# Usage:
# AUtoinclude if use_package=yes
#
class drupal::package {

    # Load the variables used in this module. Check the params.pp file 
    require drupal::params

    # Basic Package - Service - Configuration file management
    package { "drupal":
        name   => "${drupal::params::packagename}",
        ensure => present,
    }

}
