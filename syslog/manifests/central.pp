class syslog::central {

case $operatingsystem  {
    suse: { include syslog::central::suse }
    default: { include syslog::central::base }
    }
}


class syslog::central::base {
    include syslog
    config { "syslog.conf" :
        file      => "/etc/syslog.conf",
        line      => "*.*    @$syslog_server # Added by Puppet",
        engine    => "line",
        notify    => Service["syslog"],
    }
}

class syslog::central::suse {
    include syslog
    config { "Syslog-ng_destination" :
        file      => "/etc/syslog-ng/syslog-ng.conf",
        line      => "destination remote {udp(${syslog_server} port(514));}; # Added by Puppet",
        engine    => "line",
        notify    => Service["syslog-ng"],
    }

    config { "Syslog-ng_log" :
        file      => "/etc/syslog-ng/syslog-ng.conf",
        line      => 'log { source(src); destination(remote); }; # Added by Puppet',
        engine    => "line",
        notify    => Service["syslog-ng"],
    }
}
