# Define dovecot::conf
#
# General dovecot main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# dovecot::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define dovecot::conf ($value) {

    require dovecot::params

    config { "dovecot_conf_$name":
        file      => "${dovecot::params::configfile}",
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["dovecot"],
        require   => File["dovecot.conf"],
    }

}
