class samba::client {
    package {samba-client:
        name => $operatingsystem ? {
            default => "samba-client",
            },
        ensure => present,
    }
}

class samba::server inherits samba::client {

    package {samba: 
        name => $operatingsystem ? {
            default    => "samba",
            },
        ensure => present,
    }

    package {samba-swat: 
        name => $operatingsystem ? {
            default    => "samba-swat",
            },
        ensure => present,
    }

    service { smb:
        name => $operatingsystem ? {
            default => "smb",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => File["smb.conf"],
    }

    file {    
             "smb.conf":
            mode => 644, owner => root, group => root,
            require => Package["samba"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/samba/smb.conf",
            },
            notify => Service["smb"],
    }

    file {    
             "/etc/xinetd.d/swat":
            mode => 644, owner => root, group => root,
            require => Package["samba-swat"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/xinetd.d/swat",
            },
            source => "puppet://$servername/samba/swat",
    }

}

