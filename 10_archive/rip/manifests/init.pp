class rip {
##
# Variables
    package {
        "rip":
            ensure => "present",
    }
    
    service {
        "ripd":
            enable    => "true",
            require   => [
                Package["rip"],
                File["ripd.conf"]
            ],
            ensure    => "running",
            hasstatus => "true",
            subscribe => File["ripd.conf"],
    }

    file {
        "ripd.conf":
            owner   => root,
            group   => root,
            mode    => 644,
            ensure    => present,
            require => Package["rip"],
            path    => $operatingsystem ?{
                default => "/etc/ripd/ripd.conf",
                },
    }

}
