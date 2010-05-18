class vsftpd {

    package { vsftpd:
        name   => $operatingsystem ? {
            default    => "vsftpd",
            },
        ensure => present,
    }

    service { vsftpd:
        name => $operatingsystem ? {
            default => "vsftpd",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["vsftpd"],
        subscribe => File["vsftpd.conf"],
    }

    file {    
             "vsftpd.conf":
            mode => 644, owner => root, group => root,
            require => Package[vsftpd],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/vsftpd/vsftpd.conf",
            },
    }
}

