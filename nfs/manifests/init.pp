class nfs {

    package { nfs-utils:
        name => $operatingsystem ? {
            default => "nfs-utils",
            },
        ensure => present,
    }

    package { portmap:
        name => $operatingsystem ? {
            default => "portmap",
            },
        ensure => present,
    }

    file {
        "exports":
            owner   => "root",
            group   => "root",
            mode    => "644",
            ensure  => present,
            path    => $operatingsystem ?{
                default => "/etc/exports",
                },

    }

    service {
        "nfs":
        enable    => "true",
        ensure    => "running",
        hasstatus => "true",
        require   => File["exports"],
        subscribe => File["exports"],
    }

    service {
        "portmap":
        enable    => "true",
        ensure    => "running",
        hasstatus => "true",
    }

}

