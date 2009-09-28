define backup (
	$path='',
	$frequency='')
{
	
case $backup {
	no: { } ,
	yes: {

	include synbak 
	
	




	}
	default: { },
	}
}

class backup::server {

	# Temporary default backup method
	$backup_method = "synbak" ;

	case $backup_method {
		synbak: { include backup::server::synbak } ,
		rsync:  { include backup::server::rsync } ,
		backuppc:  { include backup::server::backuppc } ,
	}

	Backup_hosts <<||>>
	Backup_dirs <<||>>

}

class backup::server::synbak {

	include synbak

        file {
                "/etc/backup_synbak.conf":
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet://$server/project_coresis/synbak/backup_synbak.conf-$hostname",
        }



	synbak
}
