class mailscanner::package  {

    package { mailscanner:
        name   => $operatingsystem ? {
            debian  => "mailscanner",
            ubuntu  => "mailscanner",
            default => "MailScanner",
            },
        ensure => present,
    }

    file { "/etc/default/mailscanner":
        source => "puppet://$servername/mailscanner/mailscanner.default",
        ensure => present,
        before => Service["mailscanner"],
    }

}
