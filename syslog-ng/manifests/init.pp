class syslog-ng {

    package {
        "syslog-ng":
            ensure => "present";
    }

    service {
        "syslog-ng":
        enable    => "true",
        ensure    => "running",
        require   => File["syslog-ng.conf"],
        subscribe => File["syslog-ng.conf"],
        name      => $operatingsystem ?{
                    suse    => "syslog",
                    default => "syslog-ng",
                 },
    }

    file {
        "syslog-ng.conf":
            owner   => "root",
            group   => "root",
            mode    => "640",
            require => Package["syslog-ng"],
            ensure  => present,
            path => $operatingsystem ?{
                default => "/etc/syslog-ng/syslog-ng.conf",
            },
    }
    
}
            

class syslog-ng::server::central inherits syslog-ng {


    file {
        "/var/log/central":
            owner   => "root",
            group   => "root",
            mode    => "755",
            ensure  => "directory",
    }

    File["syslog-ng.conf"]{
        source  => "puppet://$servername/syslog-ng/syslog-ng.conf",
    }

}

class syslog-ng::server::mysql inherits syslog-ng {
    File["syslog-ng.conf"]{
        source  => "puppet://$servername/syslog-ng/syslog-ng.conf-mysql",
    }
}
