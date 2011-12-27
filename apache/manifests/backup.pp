# Class: apache::backup
#
# Backups apache data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $apache_backup_data (true|false) : Set if you want to backup apache's data. Default: As defined in $backup_data
# $apache_backup_log (true|false) : Set if you want to backup apache's logs. Default: As defined in $backup_log
# $apache_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your apache backups. Default: daily.
# $apache_backup_target : Define how to reach (Ip, fqdn...) this host to backup apache from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check apache::params
#
# Usage:
# Automatically included if $backup=yes
#
class apache::backup {

    include apache::params

    backup { "apache_data": 
        frequency => "${apache::params::backup_frequency}",
        path      => "${apache::params::datadir}",
        enabled   => "${apache::params::backup_data_enable}",
        target    => "${apache::params::backup_target_real}",
    }
    
    backup { "apache_logs": 
        frequency => "${apache::params::backup_frequency}",
        path      => "${apache::params::logdir}",
        enabled   => "${apache::params::backup_log_enable}",
        target    => "${apache::params::backup_target_real}",
    }

}
