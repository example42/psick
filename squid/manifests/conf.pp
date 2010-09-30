# Define squid::conf
#
# General squid main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# squid::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define squid::conf ($value) {

    require squid::params

    config { "squid_conf_$name":
        file      => "${squid::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["squid"],
        require   => File["squid.conf"],
    }

}
