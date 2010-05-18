# Define clamav::conf
#
# General clamav main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# clamav::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define clamav::conf ($value) {

    config { "clamav_conf_$name":
        file      => $operatingsystem ?{
                default  => "/etc/clamav/clamav.conf",
                 },
        line      => "$name $value",
        pattern   => "$name ",
        engine    => "replaceline",
        notify    => Service["clamav"],
        require   => File["clamav.conf"],
        source    => "clamav::conf",
    }

}
