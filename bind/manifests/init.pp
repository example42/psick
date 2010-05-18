class bind {

    package { bind:
        name => $operatingsystem ? {
            default    => "bind",
            },
        ensure => present,
    }

    service { named:
        name => $operatingsystem ? {
            default => "named",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => File["named.conf"],
    }

    file {    
             "named.conf":
            mode => 644, owner => root, group => root,
            require => [
                File["localdomain.zone"],
                File["localhost.zone"],
                File["named.ca"],
                File["named.local"]
            ],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/named.conf",
            },
            source => [
                "puppet://$servername/bind/named.conf-$hostname",
                "puppet://$servername/bind/named.conf"
             ],
    }

    file {    
             "localdomain.zone":
            mode => 644, owner => named, group => named,
            path => "/var/named/localdomain.zone",
            source => "puppet://$servername/bind/localdomain.zone",
    }

    file {    
             "localhost.zone":
            mode => 644, owner => named, group => named,
            ensure => present,
            path => "/var/named/localhost.zone",
            source => "puppet://$servername/bind/localhost.zone",
    }

    file {    
             "named.ca":
            mode => 644, owner => named, group => named,
            ensure => present,
            path => "/var/named/named.ca",
            source => "puppet://$servername/bind/named.ca",
    }

    file {    
             "named.local":
            mode => 644, owner => named, group => named,
            ensure => present,
            path => "/var/named/named.local",
            source => "puppet://$servername/bind/named.local",
    }

}

class bind::chroot inherits bind {

    package { bind-chroot:
        name => $operatingsystem ? {
            default    => "bind-chroot",
            },
        ensure => present,
        require => Package["bind"],
    }

    File["named.conf"] { 
            path => "/var/named/chroot/etc/named.conf",
            require => [ Package["bind-chroot"], File["/var/named/chroot/var/named"] ]
    }

    file {
        "/var/named/chroot/var/named":
            mode => 770, owner => root, group => named,
            ensure => directory,
            require => Package["bind-chroot"],
    }
            
    File["localdomain.zone"] { 
            path => "/var/named/chroot/var/named/localdomain.zone",
            require => [ Package["bind-chroot"], File["/var/named/chroot/var/named"] ]
    }

    File["localhost.zone"] { 
            path => "/var/named/chroot/var/named/localhost.zone",
            require => [ Package["bind-chroot"], File["/var/named/chroot/var/named"] ]
    }

    File["named.ca"] { 
            path => "/var/named/chroot/var/named/named.ca",
            require => [ Package["bind-chroot"], File["/var/named/chroot/var/named"] ]
    }

    File["named.local"] { 
            path => "/var/named/chroot/var/named/named.local",
            require => [ Package["bind-chroot"], File["/var/named/chroot/var/named"] ]
    }
}

class bind::dhcpupdate inherits bind::chroot {
    Package["bind"] {
            require => Package["dhcp"],
    }

    File["named.conf"] {
            source => [
                "puppet://$servername/bind/named.conf-$hostname",
                "puppet://$servername/bind/named.conf::dhcpupdate"
            ],                
    }
            
}

