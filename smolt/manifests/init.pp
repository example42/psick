class smolt {

    package { smolt:
        name   => $operatingsystem ? {
            default    => "smolt",
            },
        ensure => present,
    }

    service { smolt:
        name => $operatingsystem ? {
            default => "smolt",
            },
        ensure => stopped,
        enable => false,
        hasrestart => true,
        hasstatus => true,
        require => Package["smolt"],
        subscribe => File["minion.conf"],
    }

    file {
        "smolt_config.py":
            mode => 644, owner => root, group => root,
            require => Package[smolt],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/smolt/config.py",
            },
    }

}

class smolt::enable inherits smolt {
    Service ["smoltd"] {
        ensure => running,
        enable => true,
    }

    File ["minion.conf"] {
        content => template("smolt_config.py"),
    }

}

class smolt::disable inherits smolt {
    Service ["smoltd"] {
        ensure => stopped,
        enable => false,
    }
}

class smolt::adbsent inherits smolt {
    Package ["smolt"] {
        ensure => absent,
    }
}

define smolt::config ($value) {

    # Augeas version. 
    augeas {
        "smolt_config_$name":
        context =>  "/files/etc/smolt/config.py",
        changes =>  "set $name $value",
        onlyif  =>  "get $name != $value",
        # onlyif  =>  "match $name/*[.='$value'] size == 0",
    }

}
