class spamassassin {

    package { spamassassin:
        name => $operatingsystem ? {
            default    => "spamassassin",
            },
        ensure => present,
    }

    service { spamassassin:
        name => $operatingsystem ? {
            default => "spamassassin",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["spamassassin"],
    }

}
