class cron::crontabs {

    package { crontabs:
        name => $operatingsystem ? {
            redhat  => "crontabs",
            centos  => "crontabs",
            },
        ensure => present,
    }

}
