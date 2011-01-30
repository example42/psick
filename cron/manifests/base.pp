class cron::base {

    include cron::params 

    package { cron:
        name   => "${cron::params::packagename}" ,
        ensure => present,
    }

    service { crond:
        name    => "${cron::params::servicename}" ,
        ensure  => running,
        enable  => true,
        pattern => cron,
        require => Package["cron"],
    }

}
