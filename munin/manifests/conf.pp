# Define munin::conf
#
# General munin main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# munin::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define munin::conf ($value) {

    require munin::params

    config { "munin_conf_$name":
        file      => "${munin::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["munin-node"],
        require   => File["munin-node.conf"],
    }

}
