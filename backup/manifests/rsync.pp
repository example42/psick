# Custom Rsync simple backup system
# Backup clients offer rsync access to backup server (backup clients have a rsync service running)
# On Backup clients use the custom "backup_rsync" define (or, better, the "backup" wrap define")
# Backup server crontabs a simple script that fetches data from clients via rsync 
# On Backup server include "backup::rsync" class (or, better, the "backup::server" wrap class)

class backup::rsync {
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

define backup_rsync ( $path='', $frequency='' , $host='' ) {
	
	include rsync

        @@file {
                "/tmp/rsync_${name}":
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
			tag	=> "backup_rsync",
                        content => "/usr/local/bin/rsyncssh.sh $host $path",
        }

}

