# Class: snmpd::backup
#
# Backups snmpd data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $snmpd_backup_data (true|false) : Set if you want to backup snmpd's data. Default: As defined in $backup_data
# $snmpd_backup_log (true|false) : Set if you want to backup snmpd's logs. Default: As defined in $backup_log
# $snmpd_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your snmpd backups. Default: daily.
# $snmpd_backup_target : Define how to reach (Ip, fqdn...) this host to backup snmpd from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check snmpd::params
#
# Usage:
# Automatically included if $backup=yes
#
class snmpd::backup {

    include snmpd::params

    backup { "snmpd_data": 
        frequency => "${snmpd::params::backup_frequency}",
        path      => "${snmpd::params::datadir}",
        enabled   => "${snmpd::params::backup_data_enable}",
        target    => "${snmpd::params::backup_target_real}",
    }
    
    backup { "snmpd_logs": 
        frequency => "${snmpd::params::backup_frequency}",
        path      => "${snmpd::params::logdir}",
        enabled   => "${snmpd::params::backup_log_enable}",
        target    => "${snmpd::params::backup_target_real}",
    }

}
