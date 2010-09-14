# Define openssh::conf
# TO TEST
# General openssh main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# openssh::conf    { "protocols":  value => "imap imaps pop3 pop3s" }
#
define openssh::conf ($value) {

    include openssh::params

    config { "openssh_conf_$name":
        file      => "${openssh::params::configfile}",
        line      => "$name $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["openssh"],
        require   => File["sshd_config"],
    }

}
