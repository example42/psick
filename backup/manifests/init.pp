# Experimental backup meta-class
# This can be used to backup data via different (also custom) methods. Using, client-side a standard custom type "backup"

# Define here the backup method you want. If you want use a new one, or more than a single one, customize your $backup_method variable
# and the relevant operations / includes both in the "backup" define and in the "backup::server" class.

# Note that you might add some custom properties to the backup define according to the needs of your backup systems.

import "*.pp"

# $backup_method = "rsync" 
$backup_method = "rsyncssh"

define backup ( $path='', $frequency='daily' , $host='' ) {
# This is the general backup wrapper, it calls different backup defines according to the backup method you've chosen before

	case $backup_method {

		rsyncssh: { 
			backup_rsyncssh { "$name": 
		                frequency => "$frequency",
                		path      => "$path",
                		host      => "$host",
			} 
		}
 
		rsync: { 
			backup_rsync { "$name": 
		                frequency => "$frequency",
                		path      => "$path",
                		host      => "$host",
			} 
		}
 
		default:  {
			err("No Backup Method. Variable \$backup_method must be defined" )
		}
	}
}


class backup::server {
# This is the general backup class to be used on the backup server
# It includes the specific backup class according to your $backup_method
	case $backup_method {
		rsyncssh:  { include backup::rsyncssh::server }
		rsync:  { include backup::rsync::server }
		default:  { err("No Backup Method. Variable \$backup_method must be defined" ) }
	}
}


class backup::target {
# This is the general backup class to be used on the host you want to backup
# It includes the specific backup class according to your $backup_method
	case $backup_method {
		rsyncssh:  { include backup::rsyncssh::target }
		rsync:  { include backup::rsync::target }
		default:  { err("No Backup Method. Variable \$backup_method must be defined" ) }
	}
}
