class network {

    service { network:
        name => $operatingsystem ? {
            default => "network",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
    }

}
