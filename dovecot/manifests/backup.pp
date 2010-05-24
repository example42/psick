# Class: dovecot::backup
#
# Backups dovecot data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include dovecot::backup
#
class dovecot::backup {

# If you want set the mailbox directory (here /home) and enable it
    backup { "dovecot_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/home",
        },        
        enabled    => false,
        host => $fqdn,
    }

}
