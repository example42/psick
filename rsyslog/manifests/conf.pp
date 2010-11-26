# Define rsyslog::conf
#
# General rsyslog main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# rsyslog::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define rsyslog::conf ($value) {

    require rsyslog::params

    config { "rsyslog_conf_$name":
        file      => "${rsyslog::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["rsyslog"],
        require   => File["rsyslog.conf"],
    }

}
