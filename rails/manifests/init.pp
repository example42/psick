class rails {

    package { rails:
        name   => $operatingsystem ? {
            default    => "rails",
            },
        ensure => present,
        provider => gem,
    }

}

