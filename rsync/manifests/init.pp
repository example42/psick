class rsync {

    include xinetd

    package { rsync:
        name => $operatingsystem ? {
            default => "rsync",
            },
        ensure => present,
    }

    file {
        "/etc/xinetd.d/rsync":
            mode => 640, owner => root,
            group => $operatingsystem ?{
                freebsd => "wheel",
                default => "root",
            },
            require => Package["xinetd"],
            ensure => present,
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/xinetd.d/rsync",
                default => "/etc/xinetd.d/rsync",
            },
#            source => "puppet://$server/rsync/rsync.xinetd",
    }

    file {
        "rsyncd.conf":
#            mode => 640, owner => root, group => root,
            require => Package["rsync"],
            ensure => present,
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/rsyncd.conf",
                default => "/etc/rsyncd.conf",
            },
    }

    file {
        "rsyncd.secrets":
            mode => 600, owner => root,
            group => $operatingsystem ?{
                freebsd => "wheel",
                default => "root",
            },
            require => File["rsyncd.conf"],
            ensure => present,
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/rsyncd.secrets",
                default => "/etc/rsyncd.secrets",
            },
    }

}
