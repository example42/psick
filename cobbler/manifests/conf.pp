# Define cobbler::conf
#
# General cobbler main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# cobbler::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define cobbler::conf ($value) {

    require cobbler::params

    config { "cobbler_conf_$name":
        file      => "${cobbler::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["cobbler"],
        require   => File["cobbler.conf"],
    }

}
