class openvpn {

    package { openvpn:
        name => $operatingsystem ? {
            default    => "openvpn",
            },
        ensure => present,
    }

    service { openvpn:
        name => $operatingsystem ? {
            default => "openvpn",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package[openvpn],
    }

    file {    
             "/etc/openvpn/server.conf":
            mode => 644, owner => root, group => root,
            require => Package[openvpn],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/openvpn/server.conf",
            },
    }

}
