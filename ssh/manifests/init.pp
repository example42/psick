import "*.pp"

class ssh {

    package { ssh:
        name   => $operatingsystem ? {
            default    => "openssh",
            },
        ensure => present,
    }

    package { ssh-client:
        name   => $operatingsystem ? {
            default    => "openssh-clients",
            },
        ensure => present,
    }

}

class ssh::server {

    include ssh

    package { sshd:
        name   => $operatingsystem ? {
            default    => "openssh-server",
            },
        ensure => present,
    }

    service { sshd:
        name => $operatingsystem ? {
            default => "sshd",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["sshd"],
        subscribe => File["sshd.conf"],
    }

    file {    
             "sshd_config":
            mode => 600, owner => root, group => root,
            require => Package[ssh-server],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/ssh/sshd_config",
            },
    }

}

define ssh::config ($value) {

    # Augeas version. 
    augeas {
        "sshd_config_$name":
        context =>  "/files/etc/ssh/sshd_config",
        changes =>  "set $name $value",
        onlyif  =>  "get $name != $value",
        # onlyif  =>  "match $name/*[.='$value'] size == 0",
    }

    # Davids' replaceline version (to fix) 
    # replaceline {
    #    "sshd_config_$name":
    #    file => "/etc/ssh/sshd_config",
    #    pattern => "$name",
    #    replacement => "^$name $value",
    # }
}
