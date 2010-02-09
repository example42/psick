class syslog::central inherits syslog::base {

        config { "syslog.conf" :
                file      => "/etc/syslog.conf",
                line      => "*.*	@$syslog_server # Added by Puppet",
                engine    => "line",
		notify    => Service["syslog"],
        }

}
