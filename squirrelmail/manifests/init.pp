class squirrelmail {

    package { squirrelmail:
        name => $operatingsystem ? {
            default    => "squirrelmail",
            },
        ensure => present,
    }

}
