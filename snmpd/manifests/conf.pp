# Define snmpd::conf
#
# General snmpd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# snmpd::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define snmpd::conf ($value) {

    require snmpd::params

    config { "snmpd_conf_$name":
        file      => "${snmpd::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["snmpd"],
        require   => File["snmpd.conf"],
    }

}
