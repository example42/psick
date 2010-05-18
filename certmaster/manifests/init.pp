class certmaster {

    package { certmaster:
        name   => $operatingsystem ? {
            default    => "certmaster",
            },
        ensure => present,
    }

    service { certmaster:
        name => $operatingsystem ? {
            default => "certmaster",
            },
        ensure => stopped,
        enable => false,
        hasrestart => true,
        hasstatus => true,
        require => Package["certmaster"],
        subscribe => File["certmaster.conf"],
    }

    file {
        "certmaster.conf":
            mode => 644, owner => root, group => root,
            require => Package[certmaster],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/certmaster/certmaster.conf",
            },
    }



}

class certmaster::enable inherits certmaster {
#    include certmaster
    Service ["certmaster"] {
        ensure => running,
        enable => true,
    }
}

class certmaster::disable inherits certmaster {
    Service ["certmaster"] {
        ensure => stopped,
        enable => false,
    }
}

class certmaster::adbsent inherits certmaster {
    Package ["certmaster"] {
        ensure => absent,
    }
}

define certmaster::config ($value) {

    # Augeas version. 
    augeas {
        "certmaster_config_$name":
        context =>  "/files/etc/certmaster/certmaster.conf",
        changes =>  "set $name $value",
        onlyif  =>  "get $name != $value",
        # onlyif  =>  "match $name/*[.='$value'] size == 0",
    }

}
