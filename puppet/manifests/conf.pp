# Define puppet::conf
#
# General puppet main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# puppet::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define puppet::conf ($value) {

    require puppet::params

    config { "puppet_conf_$name":
        file      => "${puppet::params::configfile}",
        line      => "$name = $value",
        pattern   => "$name ",
        engine    => "replaceline",
        notify    => Service["puppet"],
        require   => File["puppet.conf"],
        source    => "puppet::conf",
    }

}
