# Define autofs::conf
# TO TEST
# General autofs main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# autofs::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define autofs::conf ($value) {

    config { "autofs_conf_$name":
        file      => $operatingsystem ?{
                default  => "/etc/auto.master",
                 },
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["autofs"],
        require   => File["main.cf"],
        source    => "autofs::conf",
    }

}
