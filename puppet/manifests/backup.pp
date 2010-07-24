# Class: puppet::backup
#
# Backups puppet data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include puppet::backup
#
class puppet::backup {

    backup { "puppet_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/lib/puppet",
        },        
        enabled    => true,
        host => $fqdn,
    }
    

    backup { "puppet_config": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/etc/puppet",
        },        
        enabled    => true,
        host => $fqdn,
    }
    
}
