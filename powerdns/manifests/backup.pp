# Class: powerdns::backup
#
# Backups powerdns data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $powerdns_backup_data (true|false) : Set if you want to backup powerdns's data. Default: As defined in $backup_data
# $powerdns_backup_log (true|false) : Set if you want to backup powerdns's logs. Default: As defined in $backup_log
# $powerdns_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your powerdns backups. Default: daily.
# $powerdns_backup_target : Define how to reach (Ip, fqdn...) this host to backup powerdns from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check powerdns::params
#
# Usage:
# Automatically included if $backup=yes
#
class powerdns::backup {

    include powerdns::params

    backup { "powerdns_data": 
        frequency => "${powerdns::params::backup_frequency}",
        path      => "${powerdns::params::datadir}",
        enabled   => "${powerdns::params::backup_data_enable}",
        target    => "${powerdns::params::backup_target_real}",
    }
    
    backup { "powerdns_logs": 
        frequency => "${powerdns::params::backup_frequency}",
        path      => "${powerdns::params::logdir}",
        enabled   => "${powerdns::params::backup_log_enable}",
        target    => "${powerdns::params::backup_target_real}",
    }

}
