class cron::crontabs {

    package { crontabs:
        name => "crontabs",
        ensure => present,
    }

}
