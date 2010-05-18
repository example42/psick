# Class: backup
# Experimental backup meta-class
# This can be used to backup data via different (also custom) methods. Using, client-side a standard custom type "backup"
#
# Note that you might add some custom properties to the backup define according to the needs of your backup systems.

import "*.pp"

define backup ( $path='', $frequency='daily' , $host='' , $enabled="true" ) {
# This is the general backup wrapper, it calls different backup defines according to the backup method you've chosen before

case $enabled  {
    true,yes: {

        if $backup_rsyncssh == "yes" {
            backup_rsyncssh { "$name": 
                frequency => "$frequency",
                   path      => "$path",
                       host      => "$host",
            } 
        }
 
        if $backup_rsync == "yes" {
            backup_rsync { "$name": 
                frequency => "$frequency",
                      path      => "$path",
                      host      => "$host",
            } 
        }

    }

    default: {
        # Nothing to do
    }

} # End case

}


class backup::server {
# This is the general backup class to be used on the backup server
# It includes the specific backup class if $backup_<backuptype> is set to yes
if $backup_rsyncssh == "yes" { include backup::rsyncssh::server }
if $backup_rsync == "yes" { include backup::rsync::server }

}


class backup::target {
# This is the general backup class to be used on the host you want to backup
# It includes the specific backup class if $backup_<backuptype> is set to yes
if $backup_rsyncssh == "yes" { include backup::rsyncssh::target }
if $backup_rsync == "yes" { include backup::rsync::target }

}
