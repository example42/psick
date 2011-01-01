class ntop {

    package { ntop:
        name => $operatingsystem ? {
            default => "ntop",
            },
        ensure => present,
    }

    service { ntop:
        name => $operatingsystem ? {
            default => "ntop",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
    }

    file {
        "ntop.conf":
            mode => 600, owner => root, group => root,
            require => Package[ntop],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/ntop.conf",
            },
    }

}

