class psad::debian {

    config { "psadfifo" :
        file      => $operatingsystem ?{
                default => "/etc/syslog.conf",
                 },
        line      => "kern.info        |/var/lib/psad/psadfifo # Added by Puppet",
        engine    => "line",
        notify    => [ Service["psad"], Service["syslog"] ]
    }


}
