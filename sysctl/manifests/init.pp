import "defines/*.pp"

class sysctl {

    require sysctl::params

    file { "sysctl.conf":
            mode   => 644, owner => root, group => root,
            ensure => present,
            path   => "${sysctl::params::configfile}",
    }

    exec { "sysctl -p":
            subscribe   => File["sysctl.conf"],
            refreshonly => true,
    }
}

