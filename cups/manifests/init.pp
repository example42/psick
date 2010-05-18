class cups {

    package { cups:
        name => $operatingsystem ? {
            default    => "cups",
            },
        ensure => present,
    }

    service { cups:
        name => $operatingsystem ? {
            default => "cups",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["cups"],
    }

    file {    
             "cupsd.conf":
            mode => 640, owner => root, group => lp,
            require => Package["cups"],
            ensure => present,
            notify => Service["cups"],
            path => $operatingsystem ?{
                default => "/etc/cups/cupsd.conf",
            },
    }

    file {    
             "printers.conf":
            mode => 600, owner => root, group => lp,
            require => Package["cups"],
            ensure => present,
            notify => Service["cups"],
            path => $operatingsystem ?{
                default => "/etc/cups/printers.conf",
            },
    }

    file {    
             "lpoptions":
            mode => 644, owner => root, group => root,
            require => Package["cups"],
            ensure => present,
            notify => Service["cups"],
            path => $operatingsystem ?{
                default => "/etc/cups/lpoptions",
            },
    }

}
