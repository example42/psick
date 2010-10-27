# Define collectd::conf
#
# General collectd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# collectd::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define collectd::conf ($value) {

    require collectd::params

    config { "collectd_conf_$name":
        file      => "${collectd::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["collectd"],
        require   => File["collectd.conf"],
    }

}
