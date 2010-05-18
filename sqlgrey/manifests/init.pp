class sqlgrey {

    package { sqlgrey:
        name => $operatingsystem ? {
            default    => "sqlgrey",
            },
        ensure => present,
    }

    service { sqlgrey:
        name => $operatingsystem ? {
            default => "sqlgrey",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package[sqlgrey],
        subscribe => File["sqlgrey.conf"],
    }

    file {    
             "sqlgrey.conf":
            mode => 644, owner => root, group => root,
            require => Package[sqlgrey],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/sqlgrey/sqlgrey.conf",
            },
    }
    
}
