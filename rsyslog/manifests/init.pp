# Class rsyslog
# It disables syslog to avoid conflicts
class rsyslog {

include syslog::disable

    package {
        "rsyslog":
        ensure => present,
        name => $operatingsystem ? {
            default => "rsyslog",
            },
    }

    file {
        "rsyslog.conf":
        owner   => "root",
        group   => "root",
        mode    => "644",
        require   => Package["rsyslog"],
        path    => $operatingsystem ?{
               default => "/etc/rsyslog.conf",
               },

    }

    file {
        "rsyslog":
        owner   => "root",
        group   => "root",
        mode    => "644",
        require   => Package["rsyslog"],
        path    => $operatingsystem ?{
               default => "/etc/sysconfig/rsyslog",
               },
    }


    service {
        "rsyslog":
        enable    => "true",
        ensure    => "running",
        hasstatus => "true",
        require   => File["rsyslog.conf"],
        subscribe => File["rsyslog.conf"],
        name => $operatingsystem ? {
            default => "rsyslog",
            },
    }

}

class rsyslog::server inherits rsyslog {
    File["rsyslog.conf"] {
        content => template("rsyslog/server/rsyslog.conf.erb"),
    }
    File["rsyslog"] {
        content => template("rsyslog/server/rsyslog.erb"),
    }
}

class rsyslog::server::mysql inherits rsyslog::server {
    package {
        "rsyslog-mysql":
        ensure => present,
        name => $operatingsystem ? {
            default => "rsyslog-mysql",
            },
    }

    File["rsyslog.conf"] {
        content => template("rsyslog/server/mysql/rsyslog.conf.erb"),
    }
}

