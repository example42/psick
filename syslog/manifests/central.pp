class syslog::central inherits syslog::base {

        config { "syslog.conf" :
                file      => "/etc/syslog.conf",
                line      => "*.*	@$syslog_server",
                engine    => "line",
		notify    => Service["syslog"],
        }

}
