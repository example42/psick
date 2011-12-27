# Class: sysklogd::backup
#
# Backups sysklogd data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $sysklogd_backup_data (true|false) : Set if you want to backup sysklogd's data. Default: As defined in $backup_data
# $sysklogd_backup_log (true|false) : Set if you want to backup sysklogd's logs. Default: As defined in $backup_log
# $sysklogd_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your sysklogd backups. Default: daily.
# $sysklogd_backup_target : Define how to reach (Ip, fqdn...) this host to backup sysklogd from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check sysklogd::params
#
# Usage:
# Automatically included if $backup=yes
#
class sysklogd::backup {

    include sysklogd::params

    backup { "sysklogd_data": 
        frequency => "${sysklogd::params::backup_frequency}",
        path      => "${sysklogd::params::datadir}",
        enabled   => "${sysklogd::params::backup_data_enable}",
        target    => "${sysklogd::params::backup_target_real}",
    }
    
    backup { "sysklogd_logs": 
        frequency => "${sysklogd::params::backup_frequency}",
        path      => "${sysklogd::params::logdir}",
        enabled   => "${sysklogd::params::backup_log_enable}",
        target    => "${sysklogd::params::backup_target_real}",
    }

}
