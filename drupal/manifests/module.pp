# Define: drupal::module
#
# Installs the defined drupal module via drush
#
# Variables:
# $preferred_state (default="stable") - Define which preferred version state to use
# $site - Define for which site install the module (Default:all)
# $status - Define in what status you want the module (enable,disable,absent)
#
# Usage:
# drupal::module { modulename: }
#
# Example:
# drupal::module { "google_analitics": }
# drupal::module { "google_analitics": release_state => "dev" }
# drupal::module { "google_analitics": site => "acme" }
# drupal::module { "google_analitics": status => "disable" }

define drupal::module ( release_state="stable" , site="all" , status="enable") {

    exec { "drush-${name}":
        cwd     => "${drupal::params::sitesdir}/$site/modules",
        command => $status ? {
            enable  => $release_state ? {
                "dev"   => "${drupal::params::drush_path} dl ${name} --dev",
                "beta"  => "${drupal::params::drush_path} dl ${name} --dev",
                default => "${drupal::params::drush_path} dl ${name}",
            },
            disable => "${drupal::params::drush_path} dis ${name}",
            absent  => "rm -rf ${name}",
        },
        creates => "${drupal::params::sitesdir}/$site/modules/$name",
        require => Class["drupal::drush"],
    }

}

