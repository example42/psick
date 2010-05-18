# Class: cacti::backup
#
# Backups cacti data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include cacti::backup
#
class cacti::backup {

    backup { "cacti_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/lib/cacti",
        },        
        enabled    => true,
        host => $fqdn,
    }
    
}
