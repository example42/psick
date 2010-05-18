class syslog::server inherits syslog::base {
    File["syslog.conf"] {
        content => template("syslog/server/syslog.conf.erb"),
    }
    File["syslog"] {
        content => template("syslog/server/syslog.erb"),
    }
}
