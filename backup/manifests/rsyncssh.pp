# Custom Rsync Over SSH simple backup system
# Backup clients offer ssh access (via ssh keys) to backup server
# On Backup clients use the custom "backup_rsyncssh" define (or, better, the "backup" wrap define")
# Backup server crontabs a simple script that fetches data from clients via rsync over ssh
# On Backup server include "backup::rsyncssh" class (or, better, the "backup::server" wrap class)

# Variable defaults. Can be overriden.
if $rsyncssh_configfile { } else { $rsyncssh_configfile = "/etc/rsyncssh.conf" }
if $rsyncssh_basedir { } else { $rsyncssh_basedir = "/backup" }
if $rsyncssh_backupdir { } else { $rsyncssh_backupdir = "$rsyncssh_basedir/BACKUP" }
if $rsyncssh_archivedir { } else { $rsyncssh_archivedir = "$rsyncssh_basedir/ARCHIVE" }
if $rsyncssh_snapshotdir { } else { $rsyncssh_snapshotdir = "$rsyncssh_basedir/SNAPSHOT" }
$rsyncssh_user = "rsyncssh" 

ssh::auth::key { "$rsyncssh_user": }

class backup::rsyncssh::server  {

    ssh::auth::client { "$rsyncssh_user": }

    file {
        "/usr/local/bin/rsyncssh.sh":
            owner   => "root",
            group   => "root",
            mode    => "755",
            content => template("backup/rsyncssh/rsyncssh.sh.erb"),
    }

    file {
        [ "$rsyncssh_basedir" , "$rsyncssh_backupdir" , "$rsyncssh_archivedir" , "$rsyncssh_snapshotdir" ] : 
            owner   => "$rsyncssh_user",
            group   => "root",
            mode    => "750",
            ensure  => directory,
    }

    file {
        "${rsyncssh_configfile}":
            owner   => "root",
            group   => "root",
            mode    => "644",
            ensure  => "present",
    }

    cron {
        "rsyncssh-hourly":
            command => "/usr/local/bin/rsyncssh.sh backup hourly",
            user    => "${rsyncssh_user}",
            minute  => 0,
    }

    cron {
        "rsyncssh-daily":
            command => "/usr/local/bin/rsyncssh.sh backup daily",
            user    => "${rsyncssh_user}",
            minute  => 10,
            hour    => 3,
    }

    cron {
        "rsyncssh-weekly":
            command => "/usr/local/bin/rsyncssh.sh backup weekly",
            user    => "${rsyncssh_user}",
            minute  => 30,
            hour    => 3,
            weekday => 0,
    }

    cron {
        "rsyncssh-monthly":
            command => "/usr/local/bin/rsyncssh.sh backup monthly",
            user    => "${rsyncssh_user}",
            minute  => 45,
            hour    => 3,
            monthday => 1,
    }

    Line  <<| tag == 'backup_rsyncssh' |>>

}

class backup::rsyncssh::target {
    
    user {
        "$rsyncssh_user":
            ensure   => "present",
            managehome => "true",
    }

    file {
        "/home/$rsyncssh_user/.ssh":
            owner   => "$rsyncssh_user",
            group   => "root",
            mode    => "750",
            ensure  => "directory",
            require => User["$rsyncssh_user"],
    }

    ssh::auth::server { 
        "$rsyncssh_user":
            require => File["/home/$rsyncssh_user/.ssh"],
    }

}

define backup_rsyncssh ( $path='', $frequency='' , $host='' ) {
    
    @@line {
        "backup_rsyncssh_${host}_${name}":
            file    => "${rsyncssh_configfile}",
            line    => "${host}:${path}:${frequency}",
            ensure  => present,
            source  => "backup_rsyncssh",
    }

}

