# Class: drupal::backup::absent
#
# Remove drupal backup elements
#
class drupal::backup::absent {

    include drupal::params

    backup { "drupal_data": 
        frequency => "${drupal::params::backup_frequency}",
        path      => "${drupal::params::datadir}",
        enabled   => "false",
        target    => "${drupal::params::backup_target_real}",
    }
    
    backup { "drupal_logs": 
        frequency => "${drupal::params::backup_frequency}",
        path      => "${drupal::params::logdir}",
        enabled   => "false",
        target    => "${drupal::params::backup_target_real}",
    }

}
