# Define: drupal::theme
#
# Installs the defined drupal theme via drush
#
# Variables:
# $preferred_state (default="stable") - Define which preferred version state to use
# $site - Define for which site install the theme (Default:all)
# $status - Define in what status you want the theme (enable,disable,absent)
#
# Usage:
# drupal::theme { themename: }
#
# Example:
# drupal::theme { "google_analitics": }
# drupal::theme { "google_analitics": preferred_state => "beta" }
# drupal::theme { "google_analitics": site => "acme" }
# drupal::theme { "google_analitics": status => "disable" }

define drupal::theme ( preferred_state="stable" , site="all" , status="enable") {

    exec { "drush-${name}":
        cwd     => "${drupal::params::sitesdir}/$site/themes",
        command => $status ? {
            enable  => "${drupal::params::drush_path} dl ${name}",
            disable => "${drupal::params::drush_path} dis ${name}",
            absent  => "rm -rf ${name}",
        },
        creates => "${drupal::params::sitesdir}/$site/themes/$name",
        require => Class["drupal::drush"],
    }

}

