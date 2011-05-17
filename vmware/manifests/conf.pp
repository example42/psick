# Define vmware::conf
#
# General vmware main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# vmware::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define vmware::conf ($value) {

    require vmware::params

    config { "vmware_conf_$name":
        file      => "${vmware::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["vmware"],
        require   => File["vmware.conf"],
    }

}
