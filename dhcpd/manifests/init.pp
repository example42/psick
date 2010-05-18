class dhcpd {

    package { dhcp:
        name => $operatingsystem ? {
            default    => "dhcp",
            },
        ensure => present,
    }

    service { dhcpd:
        name => $operatingsystem ? {
            default => "dhcpd",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package[dhcp],
    }

    file {    
             "dhcpd.conf":
            mode => 644, owner => root, group => root,
            require => Package[dhcp],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/dhcpd.conf",
            },
    }

    file {    
             "/etc/sysconfig/dhcpd":
            mode => 644, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/sysconfig/dhcpd",
            },
            source => "puppet://$servername/dhcpd/dhcpd.sysconfig",
    }

}
