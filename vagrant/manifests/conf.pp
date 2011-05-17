# Define vagrant::conf
#
# General vagrant main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# vagrant::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define vagrant::conf ($value) {

    require vagrant::params

    config { "vagrant_conf_$name":
        file      => "${vagrant::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["vagrant"],
        require   => File["vagrant.conf"],
    }

}
