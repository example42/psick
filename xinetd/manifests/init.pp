class xinetd {
    service {
        "xinetd":
        enable    => "true",
        ensure    => "running",
        require   => File["/etc/xinetd.conf"],
        subscribe => File["/etc/xinetd.conf"],
        name => $operatingsystem ? {
            default => "xinetd",
            },

    }

    package {
        "xinetd":
        ensure => present,
        name => $operatingsystem ? {
            default => "xinetd",
            },
    }
    
    file {
        "/etc/xinetd.conf":
#        owner  => root, group  => root,    mode   => 644,
        require => Package["xinetd"],
        ensure => present,
        path => $operatingsystem ?{
            freebsd => "/usr/local/etc/xinetd.conf",
            default => "/etc/xinetd.conf",
        }
    }
}
