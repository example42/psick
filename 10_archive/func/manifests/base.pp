class func::base {

    package { func:
        name   => $operatingsystem ? {
            default    => "func",
            },
        ensure => present,
    }

    service { funcd:
        name => $operatingsystem ? {
            default => "funcd",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["func"],
        subscribe => File["minion.conf"],
    }

    file {
        "minion.conf":
            mode => 644, owner => root, group => root,
            require => Package[func],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/func/minion.conf",
            },
    }



}

class func::enable inherits func::base {
    Service ["funcd"] {
        ensure => running,
        enable => true,
    }

    File ["minion.conf"] {
        content => template("func/minion.conf"),
    }

}

class func::disable inherits func::base {
    Service ["funcd"] {
        ensure => stopped,
        enable => false,
    }
}

class func::adbsent inherits func::base {
    Package ["func"] {
        ensure => absent,
    }
}

define func::config ($value) {

    # Augeas version. 
    augeas {
        "func_config_$name":
        context =>  "/files/etc/func/minion.conf",
        changes =>  "set $name $value",
        onlyif  =>  "get $name != $value",
        # onlyif  =>  "match $name/*[.='$value'] size == 0",
    }

}
