# Class: ntp::backup
#
# Backups ntp data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $ntp_backup_data (true|false) : Set if you want to backup ntp's data. Default: As defined in $backup_data
# $ntp_backup_log (true|false) : Set if you want to backup ntp's logs. Default: As defined in $backup_log
# $ntp_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your ntp backups. Default: daily.
# $ntp_backup_target : Define how to reach (Ip, fqdn...) this host to backup ntp from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check ntp::params
#
# Usage:
# Automatically included if $backup=yes
#
class ntp::backup {

    include ntp::params

    backup { "ntp_data": 
        frequency => "${ntp::params::backup_frequency}",
        path      => "${ntp::params::datadir}",
        enabled   => "${ntp::params::backup_data_enable}",
        target    => "${ntp::params::backup_target_real}",
    }
    
    backup { "ntp_logs": 
        frequency => "${ntp::params::backup_frequency}",
        path      => "${ntp::params::logdir}",
        enabled   => "${ntp::params::backup_log_enable}",
        target    => "${ntp::params::backup_target_real}",
    }

}
