class synbak {
       
    # Temporary fixed user
    $synbak_user = "synbak" 
    $synbak_group = "synbak" 


    include php
 
    package { synbak:
        name => $operatingsystem ? {
            default => "synbak",
            },
        ensure => present,
    }

    user {
        "$synbak_user":
            ensure  => "present",
            # uid     => "905",
            # gid     => "900",
            comment => "Synbak User",
            home    => "/home/$synbak_user",
            shell   => "/bin/bash",
            require => Group["$synbak_group"];
    }

    group {
        "$synbak_group":
            ensure  => "present",
            # gid     => "900"
    }



    # Backup Destination Directory 
    file {
        "/backup/synbak":
            owner     => $synbak_user,
            group     => $synbak_group,
            mode      => "750",
            ensure    => "directory"
    }

    # Master Backup Script
    file {
        "/usr/local/sbin/backup_synbak.sh":
            owner   => "root",
            group   => "root",
            mode    => "755",
            source  => "puppet://$server/synbak/backup_synbak.sh",
    }

    # Backup_synbak.sh config file (list of synbak jobs to perform) - Populated dynamically
    file {
        "/etc/backup_synbak.conf":
            owner   => "root",
            group   => "root",
            mode    => "644",
            ensure  => "present",
    }

    # Schedule of Backup Script
    cron {
        "/backup/synbak":
            user     => "$synbak_user",
            hour     => "0",
            minute   => "0",
            command  => "/usr/local/sbin/backup_synbak.sh"
    }

define synbak (
    $backup_host = 'absent',
    $backup_remote_uri = 'absent',
    $backup_method_opts = '',
    $backup_source = '/etc /var /home /boot',
    $backup_exclude = 'dev proc',
    $backup_destination = '/backup/synbak',
    $backup_report_email = 'root'
    ){

    file {
#        "${backup_destination}":
#            ensure => directory,
#            mode => 0750, owner => root, group => root;

        "${backup_destination}/${backup_host}":
            ensure => directory,
            mode => 0750, owner => $synbak_user, group => $synbak_group;

        "/root/.synbak/rsync/${backup_host}.conf":
            ensure => present,
            content => template("synbak/rsynctemplate.conf"),
            mode => 0750, owner => $synbak_user, group => $synbak_group;
    }

}

}
