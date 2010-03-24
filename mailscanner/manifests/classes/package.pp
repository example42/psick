class mailscanner::package  {

        package { mailscanner:
                name   => $operatingsystem ? {
                        debian  => "mailscanner",
                        ubuntu  => "mailscanner",
                        default => "MailScanner",
                        },
                ensure => present,
        }

}
