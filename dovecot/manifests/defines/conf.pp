# Define dovecot::conf
# TO TEST
# General dovecot main configuration file's inline modification define
# Use with caution, it doesn't fit well with Dovecot's conf logic based on sections
#
# Usage:
# dovecot::conf    { "protocols":  value => "imap imaps pop3 pop3s" }

define dovecot::conf ($value) {

        config { "dovecot_conf_$name":
                file      => $operatingsystem ?{
                                default  => "/etc/dovecot/main.cf",
                             },
                line      => "$name $value",
                pattern   => "$name ",
                engine    => "replaceline",
                notify    => Service["dovecot"],
                require   => File["main.cf"],
                source    => "dovecot::conf",
        }

}
