# Class: mysql::backup
#
# Backups mysql data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $mysql_backup_data (true|false) : Set if you want to backup mysql's data. Default: As defined in $backup_data
# $mysql_backup_log (true|false) : Set if you want to backup mysql's logs. Default: As defined in $backup_log
# $mysql_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your mysql backups. Default: daily.
# $mysql_backup_target : Define how to reach (Ip, fqdn...) this host to backup mysql from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check mysql::params
#
# Usage:
# Automatically included if $backup=yes
#
class mysql::backup {

    include mysql::params

    backup { "mysql_data": 
        frequency => "${mysql::params::backup_frequency}",
        path      => "${mysql::params::datadir}",
        enabled   => "${mysql::params::backup_data_enable}",
        target    => "${mysql::params::backup_target_real}",
    }
    
    backup { "mysql_logs": 
        frequency => "${mysql::params::backup_frequency}",
        path      => "${mysql::params::logdir}",
        enabled   => "${mysql::params::backup_log_enable}",
        target    => "${mysql::params::backup_target_real}",
    }

}
