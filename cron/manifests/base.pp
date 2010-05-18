class cron::base {

    package { cron:
        name => $operatingsystem ? {
            ubuntu    => "cron",
            debian    => "cron",
            redhat    => "vixie-cron",
            centos    => "vixie-cron",
            },
        ensure => present,
    }

    service { crond:
        name => $operatingsystem ? {
            ubuntu  => "cron",
            debian  => "cron",
            redhat  => "crond",
            centos  => "crond",
            },
        ensure => running,
        enable => true,
        pattern => cron,
        require => Package["cron"],
    }

}
