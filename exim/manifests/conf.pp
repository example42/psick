# Define exim::conf
#
# General exim main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# exim::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define exim::conf ($value) {

    require exim::params

    config { "exim_conf_$name":
        file      => "${exim::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["exim"],
        require   => File["exim.conf"],
    }

}
