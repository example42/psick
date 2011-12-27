# Class: openvpn::backup
#
# Backups openvpn data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $openvpn_backup_data (true|false) : Set if you want to backup openvpn's data. Default: As defined in $backup_data
# $openvpn_backup_log (true|false) : Set if you want to backup openvpn's logs. Default: As defined in $backup_log
# $openvpn_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your openvpn backups. Default: daily.
# $openvpn_backup_target : Define how to reach (Ip, fqdn...) this host to backup openvpn from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check openvpn::params
#
# Usage:
# Automatically included if $backup=yes
#
class openvpn::backup {

    include openvpn::params

    backup { "openvpn_data": 
        frequency => "${openvpn::params::backup_frequency}",
        path      => "${openvpn::params::datadir}",
        enabled   => "${openvpn::params::backup_data_enable}",
        target    => "${openvpn::params::backup_target_real}",
    }
    
    backup { "openvpn_logs": 
        frequency => "${openvpn::params::backup_frequency}",
        path      => "${openvpn::params::logdir}",
        enabled   => "${openvpn::params::backup_log_enable}",
        target    => "${openvpn::params::backup_target_real}",
    }

}
