    file { "puppet.conf":
        path    => "/etc/puppet/puppet.conf",
        ensure  => present,
        content => template("puppet.conf.erb"),
        notify  => Service["puppet"],
    }

    service { puppet:
        ensure     => running,
        enable     => true,
    }
