class samba::pdc inherits samba::server {

    service { winbind:
        name => $operatingsystem ? {
            default => "winbind",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
    }

    File["smb.conf"] {
            content => template("samba/smb.conf.erb-pdc"),
    }

    file {
        "/etc/samba/conf.d":
            mode => 755, owner => root, group => root,
            ensure => directory,
    }

    file {
        "/etc/samba/conf.d/shares.conf":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/samba/shares.conf",
            require => File["/etc/samba/conf.d"],
    }

}

