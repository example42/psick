# Define lighttpd::conf
#
# General lighttpd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# lighttpd::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define lighttpd::conf ($value) {

    require lighttpd::params

    config { "lighttpd_conf_$name":
        file      => "${lighttpd::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["lighttpd"],
        require   => File["lighttpd.conf"],
    }

}
