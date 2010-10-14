# Define activemq::conf
#
# General activemq main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# activemq::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define activemq::conf ($value) {

    require activemq::params

    config { "activemq_conf_$name":
        file      => "${activemq::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["activemq"],
        require   => File["activemq.conf"],
    }

}
