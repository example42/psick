# Class: drupal::backup
#
# Backups drupal data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $drupal_backup_data (true|false) : Set if you want to backup drupal's data. Default: As defined in $backup_data
# $drupal_backup_log (true|false) : Set if you want to backup drupal's logs. Default: As defined in $backup_log
# $drupal_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your drupal backups. Default: daily.
# $drupal_backup_target : Define how to reach (Ip, fqdn...) this host to backup drupal from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check drupal::params
#
# Usage:
# Automatically included if $backup=yes
#
class drupal::backup {

    include drupal::params

    backup { "drupal_data": 
        frequency => "${drupal::params::backup_frequency}",
        path      => "${drupal::params::datadir}",
        enabled   => "${drupal::params::backup_data_enable}",
        target    => "${drupal::params::backup_target_real}",
    }
    
    backup { "drupal_logs": 
        frequency => "${drupal::params::backup_frequency}",
        path      => "${drupal::params::logdir}",
        enabled   => "${drupal::params::backup_log_enable}",
        target    => "${drupal::params::backup_target_real}",
    }

}
