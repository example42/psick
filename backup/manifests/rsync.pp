# Custom Rsync simple backup system
# Backup clients offer rsync access to backup server (backup clients have a rsync service running)
# On Backup clients use the custom "backup_rsync" define (or, better, the "backup" wrap define")
# Backup server crontabs a simple script that fetches data from clients via rsync 
# On Backup server include "backup::rsync" class (or, better, the "backup::server" wrap class)

class backup::rsync::server {
# Tests... work in progress

    file {
        "/tmp/rsync.sh":
            owner   => "root",
            group   => "root",
            mode    => "750",
            content => template("backup/rsyncssh/rsyncssh.sh.erb"),
    }

    File  <<| tag == 'backup_rsync' |>>

}

class backup::rsync::target {
    include rsync
}



define backup_rsync ( $path='', $frequency='' , $host='' ) {
    
    include rsync

    @@file {
        "backup_rsync_${host}_${name}":
            owner   => "root",
            group   => "root",
            mode    => "644",
            tag    => "backup_rsync",
            path    => "/tmp/backup_rsync_${host}_${name}",
            content => "/usr/local/bin/rsyncssh.sh $host $path",
    }

}

