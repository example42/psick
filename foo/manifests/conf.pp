# Define foo::conf
#
# General foo main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# foo::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define foo::conf ($value) {

    require foo::params

    config { "foo_conf_$name":
        file      => "${foo::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["foo"],
        require   => File["foo.conf"],
    }

}
