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
        command => "${drupal::params::drush_path} dl drupal-${drupal::params::version}.x --destination ${drupal::params::basedir} --yes",
        creates => "${drupal::params::basedir}/index.php",
        require => Class["drupal::drush"],
    }

}
