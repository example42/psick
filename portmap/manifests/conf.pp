# Define portmap::conf
# TO TEST
# General portmap main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# portmap::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define portmap::conf ($value) {

    include portmap::params

    config { "portmap_conf_$name":
        file      => ${portmap::params::configfile},
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["portmap"],
        require   => File["exports"],
    }

}
