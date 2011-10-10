# Define powerdns::conf
#
# General powerdns main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# powerdns::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define powerdns::conf ($value) {

    require powerdns::params

    config { "powerdns_conf_$name":
        file      => "${powerdns::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["powerdns"],
        require   => File["powerdns.conf"],
    }

}
