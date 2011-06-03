# Define sysctl::conf
#
# General sysctl main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# sysctl::conf    { "net.ipv4.ip_forward":  value => "1" }

define sysctl::conf ($value) {

    include sysctl::params

    config { "sysctl_conf_${name}":
        file      => "${sysctl::params::configfile}",
        line      => "${name} = ${value}",
        pattern   => "${name}",
#        parameter  => "${name}",
#        value      => "${value}",
        engine    => "line",
        notify    => Exec["sysctl -p"],
    }

}
