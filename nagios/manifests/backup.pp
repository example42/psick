# Class: nagios::backup
#
# Backups nagios data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $nagios_backup_data (true|false) : Set if you want to backup nagios's data. Default: As defined in $backup_data
# $nagios_backup_log (true|false) : Set if you want to backup nagios's logs. Default: As defined in $backup_log
# $nagios_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your nagios backups. Default: daily.
# $nagios_backup_target : Define how to reach (Ip, fqdn...) this host to backup nagios from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check nagios::params
#
# Usage:
# Automatically included if $backup=yes
#
class nagios::backup {

    include nagios::params

    backup { "nagios_data": 
        frequency => "${nagios::params::backup_frequency}",
        path      => "${nagios::params::datadir}",
        enabled   => "${nagios::params::backup_data_enable}",
        target    => "${nagios::params::backup_target_real}",
    }
    
    backup { "nagios_logs": 
        frequency => "${nagios::params::backup_frequency}",
        path      => "${nagios::params::logdir}",
        enabled   => "${nagios::params::backup_log_enable}",
        target    => "${nagios::params::backup_target_real}",
    }

}
