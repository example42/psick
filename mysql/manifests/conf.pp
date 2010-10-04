# Define mysql::conf
#
# General mysql main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# mysql::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define mysql::conf ($value) {

    require mysql::params

    config { "mysql_conf_$name":
        file      => "${mysql::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["mysql"],
        require   => File["mysql.conf"],
    }

}
