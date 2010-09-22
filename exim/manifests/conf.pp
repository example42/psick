# Define exim::conf
# TO TEST
# General exim main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# exim::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define exim::conf ($value) {

    config { "exim_conf_$name":
        file      => "${exim::params:configfile}",
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["exim"],
        require   => File["main.cf"],
        source    => "exim::conf",
    }

}
