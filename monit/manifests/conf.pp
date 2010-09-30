# Define monit::conf
#
# General monit main configuration file's inline modification define
# Use with caution, it doesn't fit well with monit's conf logic based on containers
# Use just for ALREADY DEFINED general settings in main monitrc
#
# Usage:
# monit::conf    { "set daemon":  value => "180" }
#
define monit::conf ($value) {

    require monit::params

    config { "monit_conf_$name":
        file      => "${monit::params::configfile}",
        line      => "$name $value",
        pattern   => "$name ",
        engine    => "replaceline",
        notify    => Service["monit"],
        require   => File["monitrc"],
        source    => "monit::conf",
    }

}
