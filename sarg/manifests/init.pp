class sarg {

    include squid 

    package { sarg:
        name => $operatingsystem ? {
            default    => "sarg",
            },
        ensure => present,
    }

}
