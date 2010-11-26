# Define postfix::conf
#
# General postfix main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# postfix::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define postfix::conf ($value) {

    require postfix::params

    config { "postfix_conf_$name":
        file      => "${postfix::params::configfile}",
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["postfix"],
        require   => File["main.cf"],
    }

}
