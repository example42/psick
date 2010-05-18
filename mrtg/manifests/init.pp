class mrtg {

    include apache

    package { mrtg:
        name => $operatingsystem ? {
            default    => "mrtg",
            },
        ensure => present,
    }

    file {
        "/etc/httpd/conf.d/mrtg.conf":
            owner     => root,
            group     => root,
            mode      => 644,
            require   => Package["httpd"],
            ensure      => present,
            # source    => "puppet://$server/mrtg/mrtg.httpd",
    }

    file {
        "mrtg.cfg":
            owner     => root,
            group     => root,
            mode      => 644,
            require   => Package["mrtg"],
            ensure      => present,
            path      =>  $operatingsystem ? {
            default => "/etc/mrtg/mrtg.cfg",
            },
    }
}
