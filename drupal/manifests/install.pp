#
# Class: drupal::install
#
# Installs Drupal using the OS official install
#
# Usage:
# AUtoinclude if use_install=yes
#
class drupal::install {

    # Load the variables used in this module. Check the params.pp file 
    require drupal::params

    exec { "drupal-install":
        cwd     => "/var/www",
        command => "${drupal::params::drush_path} dl drupal-${drupal::params::version}.x --drupal-project-rename --yes",
        creates => "/var/www/drupal/index.php",
        require => Class["drupal::drush"],
    }

}
