class logrotate {

    package { logrotate:
        name => $operatingsystem ? {
            default    => "logrotate",
            },
        ensure => present,
    }

}
