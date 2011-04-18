# Define ntp::conf
#
# General ntp main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# ntp::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define ntp::conf ($value) {

    require ntp::params

    config { "ntp_conf_$name":
        file      => "${ntp::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["ntp"],
        require   => File["ntp.conf"],
    }

}
