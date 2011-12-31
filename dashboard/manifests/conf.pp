# Define dashboard::conf
# TO TEST
# General dashboard main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# dashboard::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define dashboard::conf ($value) {

    config { "dashboard_conf_$name":
        file      => "${dashboard::params::configfile}",
        line      => "$name $value",
        pattern   => "$name ",
        engine    => "replaceline",
        notify    => Service["dashboard"],
        require   => File["main.cf"],
        source    => "dashboard::conf",
    }

}
