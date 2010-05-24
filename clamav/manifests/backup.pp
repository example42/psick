# Class: clamav::backup
#
# Backups clamav data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include clamav::backup
#
class clamav::backup {

    backup { "clamav_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/spool/clamav",
        },        
        enabled    => true,
        host => $fqdn,
    }
    

    backup { "clamav_logs": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/log/maillog",
        },        
        enabled    => false,
        host => $fqdn,
    }
    
}
