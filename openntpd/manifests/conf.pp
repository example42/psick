# Define openntpd::conf
# TO TEST
# General openntpd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# openntpd::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define openntpd::conf ($value) {

    include openntpd::params

    config { "openntpd_conf_$name":
        file      => "${openntpd::params::configfile}",
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["openntpd"],
        require   => File["ntp.conf"],
    }

}
