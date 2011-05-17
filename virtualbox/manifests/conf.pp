# Define virtualbox::conf
#
# General virtualbox main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# virtualbox::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define virtualbox::conf ($value) {

    require virtualbox::params

    config { "virtualbox_conf_$name":
        file      => "${virtualbox::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["virtualbox"],
        require   => File["virtualbox.conf"],
    }

}
