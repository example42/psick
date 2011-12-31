# Class: squid::backup
#
# Backups squid data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $squid_backup_data (true|false) : Set if you want to backup squid's data. Default: As defined in $backup_data
# $squid_backup_log (true|false) : Set if you want to backup squid's logs. Default: As defined in $backup_log
# $squid_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your squid backups. Default: daily.
# $squid_backup_target : Define how to reach (Ip, fqdn...) this host to backup squid from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check squid::params
#
# Usage:
# Automatically included if $backup=yes
#
class squid::backup {

    include squid::params

    backup { "squid_data": 
        frequency => "${squid::params::backup_frequency}",
        path      => "${squid::params::datadir}",
        enabled   => "${squid::params::backup_data_enable}",
        target    => "${squid::params::backup_target_real}",
    }
    
    backup { "squid_logs": 
        frequency => "${squid::params::backup_frequency}",
        path      => "${squid::params::logdir}",
        enabled   => "${squid::params::backup_log_enable}",
        target    => "${squid::params::backup_target_real}",
    }

}
