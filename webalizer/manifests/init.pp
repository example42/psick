class webalizer {

    package { webalizer:
        name   => $operatingsystem ? {
            default    => "webalizer",
            },
        ensure => present,
    }

}

