# Define sysklogd::conf
#
# General sysklogd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# sysklogd::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define sysklogd::conf ($value) {

    require sysklogd::params

    config { "sysklogd_conf_$name":
        file      => "${sysklogd::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["sysklogd"],
        require   => File["sysklogd.conf"],
    }

}
