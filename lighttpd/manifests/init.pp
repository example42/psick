class lighttpd {

    package { lighttpd:
        name => $operatingsystem ? {
            default    => "lighttpd",
            },
        ensure => present,
    }

    service { lighttpd:
        name => $operatingsystem ? {
            default => "lighttpd",
            },
    #    ensure => running,
    #    enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["lighttpd"],
        subscribe => File["lighttpd.conf"],
    }

    file {
        "lighttpd.conf":
            mode => 640, owner => root, group => root,
            require => Package["lighttpd"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/lighttpd/lighttpd.conf",
            },
    }

}


class lighttpd::fastcgi inherits lighttpd {
    package { lighttpd-fastcgi:
        name => $operatingsystem ? {
            default => "lighttpd-fastcgi",
            },
        ensure => present,
    }
}
