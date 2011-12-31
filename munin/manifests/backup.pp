# Class: munin::backup
#
# Backups munin data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $munin_backup_data (true|false) : Set if you want to backup munin's data. Default: As defined in $backup_data
# $munin_backup_log (true|false) : Set if you want to backup munin's logs. Default: As defined in $backup_log
# $munin_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your munin backups. Default: daily.
# $munin_backup_target : Define how to reach (Ip, fqdn...) this host to backup munin from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check munin::params
#
# Usage:
# Automatically included if $backup=yes
#
class munin::backup {

    include munin::params

    backup { "munin_data": 
        frequency => "${munin::params::backup_frequency}",
        path      => "${munin::params::datadir}",
        enabled   => "${munin::params::backup_data_enable}",
        target    => "${munin::params::backup_target_real}",
    }
    
    backup { "munin_logs": 
        frequency => "${munin::params::backup_frequency}",
        path      => "${munin::params::logdir}",
        enabled   => "${munin::params::backup_log_enable}",
        target    => "${munin::params::backup_target_real}",
    }

}
