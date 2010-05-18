class squid {

    package { squid:
        name => $operatingsystem ? {
            default    => "squid",
            },
        ensure => present,
    }

    service { squid:
        name => $operatingsystem ? {
            default => "squid",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => File["squid.conf"],
        subscribe => File["squid.conf"],
    }

    file {    
             "squid.conf":
            mode => 640, owner => root, group => root,
            require => Package["squid"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/squid/squid.conf",
            },
            content => template("squid/squid.conf"),
    }
}

class squid::transparent inherits squid {
    File["squid.conf"] { 
            content => template("squid/squid.conf-transparent"),
    }
}

class squid::havp inherits squid {

    package { havp:
        name => $operatingsystem ? {
            default    => "havp",
            },
        ensure => present,
    }

    service { havp:
        name => $operatingsystem ? {
            default => "havp",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        require => File["havp.config"],
        subscribe => File["havp.config"],
    }

    file {    
             "/var/log/havp":
            mode => 755, owner => clamav, group => clamav,
            require => Package["havp"],
            ensure => directory,
    }

    file {    
             "/var/run/havp":
            mode => 755, owner => clamav, group => clamav,
            require => Package["havp"],
            ensure => directory,
    }
    
    file {    
             "/var/tmp/havp":
            mode => 755, owner => clamav, group => clamav,
            require => Package["havp"],
            ensure => directory,
    }

    mount {
        "/var/tmp/havp":
            ensure  => "mounted",
            fstype  => "ramfs",
            device  => "/dev/ram0",
            atboot  => "true",
            require => [ Package["havp" ] ],
            dump    => "0",
            pass    => "0",
            options => "mand,noatime,async,uid=clamav,gid=clamav"
    }

    file {    
             "/usr/local/sbin/havp":
            mode => 750, owner => clamav, group => root,
            require => Package["havp"],
            ensure => "/usr/sbin/havp",
    }

    file {    
             "havp.config":
            mode => 640, owner => root, group => root,
            require => Package["havp"],
            path => $operatingsystem ?{
                default => "/etc/havp/havp.config",
            },
            source => "puppet://$servername/squid/havp.config",
    }

    File["squid.conf"] { 
            content => template("squid/squid.conf-havp"),
    }
}


class squid::auth inherits squid {
    File["squid.conf"] { 
            content => template("squid/squid.conf-auth"),
    }
}

class squid::havp::auth inherits squid::havp {
    File["squid.conf"] { 
            content => template("squid/squid.conf-havp-auth"),
    }
}
