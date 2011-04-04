# Define openvpn::conf
#
# General openvpn main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# openvpn::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define openvpn::conf ($value) {

    require openvpn::params

    config { "openvpn_conf_$name":
        file      => "${openvpn::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["openvpn"],
        require   => File["openvpn.conf"],
    }

}
