class symbolic {

    package { symbolic:
        name   => $operatingsystem ? {
            default    => "symbolic",
            },
        ensure => present,
    }

    service { symbolic:
        name => $operatingsystem ? {
            default => "symbolic",
            },
        ensure => stopped,
        enable => false,
        hasrestart => true,
        hasstatus => true,
        require => Package["symbolic"],
        subscribe => File["SymbolicConf.properties"],
    }

    file {
        "SymbolicConf.properties":
            require => Package[symbolic],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/symbolic/conf/SymbolicConf.properties",
            },
    }

}

class symbolic::enable inherits symbolic {
    Service ["symbolic"] {
        ensure => running,
        enable => true,
    }
}

class symbolic::disable inherits symbolic {
    Service ["symbolic"] {
        ensure => stopped,
        enable => false,
    }
}

class symbolic::adbsent inherits symbolic {
    Package ["symbolic"] {
        ensure => absent,
    }
}

class symbolic::config inherits symbolic {

    File ["SymbolicConf.properties"] {
#            content => template("symbolic/SymbolicConf.properties"),
    }

}
