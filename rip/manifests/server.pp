class rip::server inherits rip {

    File["ripd.conf"] {
        content => template("rip/ripd.conf"),
    }

    file {
        "sesamo.sh":
            owner   => root,
            group   => root,
            mode    => 750,
            ensure  => present,
            content => template("rip/sesamo.sh"),
            require => Package["rip"],
            path    => "/root/sesamo.sh",
    }

    file {
        "iptablesreload.sh":
            owner   => root,
            group   => root,
            mode    => 750,
            ensure  => present,
            content => "service iptables restart",
            require => Package["rip"],
            path    => "/etc/cron.daily/iptablesreload.sh",
    }

}

