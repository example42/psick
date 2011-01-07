# Class drupal::drush
# 
# Installs drush for Drupal
# Autoloaded if $drupal_use_drush = yes 
#
class drupal::drush {

    require drupal::params

    netinstall { "netinstall_drush":
        url              => "${drupal::params::drush_url}",
        extracted_dir    => "drush",
        destination_dir  => "${drupal::params::sitesdir}/all/modules",
    }

    file { drush_link:
        path  => "/usr/bin/drush",
        ensure => "${drupal::params::drush_path}",
    }
}
