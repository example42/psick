# Define nfs::conf
# TO TEST
# General nfs main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# nfs::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define nfs::conf ($value) {

    include nfs::params

    config { "nfs_conf_$name":
        file      => ${nfs::params::configfile},
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["nfs"],
        require   => File["exports"],
    }

}
