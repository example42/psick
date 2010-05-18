# Class: postfix::backup
#
# Backups postfix data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include postfix::backup
#
class postfix::backup {

    backup { "postfix_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/spool/postfix",
        },        
        enabled    => true,
        host => $fqdn,
    }
    

    backup { "postfix_logs": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/log/maillog",
        },        
        enabled    => false,
        host => $fqdn,
    }
    
}
