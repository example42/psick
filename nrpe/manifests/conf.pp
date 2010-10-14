# Define nrpe::conf
#
# General nrpe main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# nrpe::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define nrpe::conf ($value) {

    require nrpe::params

    config { "nrpe_conf_$name":
        file      => "${nrpe::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["nrpe"],
        require   => File["nrpe.conf"],
    }

}
