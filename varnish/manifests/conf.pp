# Define varnish::conf
#
# General varnish main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# varnish::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define varnish::conf ($value) {

    require varnish::params

    config { "varnish_conf_$name":
        file      => "${varnish::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["varnish"],
        require   => File["varnish.conf"],
    }

}
