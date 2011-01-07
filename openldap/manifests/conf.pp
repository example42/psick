# Define openldap::conf
#
# General openldap main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# openldap::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define openldap::conf ($value) {

    require openldap::params

    config { "openldap_conf_$name":
        file      => "${openldap::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["openldap"],
        require   => File["openldap.conf"],
    }

}
