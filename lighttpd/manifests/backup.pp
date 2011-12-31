# Class: lighttpd::backup
#
# Backups lighttpd data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $lighttpd_backup_data (true|false) : Set if you want to backup lighttpd's data. Default: As defined in $backup_data
# $lighttpd_backup_log (true|false) : Set if you want to backup lighttpd's logs. Default: As defined in $backup_log
# $lighttpd_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your lighttpd backups. Default: daily.
# $lighttpd_backup_target : Define how to reach (Ip, fqdn...) this host to backup lighttpd from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check lighttpd::params
#
# Usage:
# Automatically included if $backup=yes
#
class lighttpd::backup {

    include lighttpd::params

    backup { "lighttpd_data": 
        frequency => "${lighttpd::params::backup_frequency}",
        path      => "${lighttpd::params::datadir}",
        enabled   => "${lighttpd::params::backup_data_enable}",
        target    => "${lighttpd::params::backup_target_real}",
    }
    
    backup { "lighttpd_logs": 
        frequency => "${lighttpd::params::backup_frequency}",
        path      => "${lighttpd::params::logdir}",
        enabled   => "${lighttpd::params::backup_log_enable}",
        target    => "${lighttpd::params::backup_target_real}",
    }

}
