# Define portmap::conf
#
# General portmap main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# portmap::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define portmap::conf ($value) {

    require portmap::params

    config { "portmap_conf_$name":
        file      => "${portmap::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["portmap"],
        require   => File["portmap.conf"],
    }

}
