# Define nagios::conf
#
# General nagios main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# nagios::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define nagios::conf ($value) {

    require nagios::params

    config { "nagios_conf_$name":
        file      => "${nagios::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["nagios"],
        require   => File["nagios.conf"],
    }

}
