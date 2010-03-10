# Define postfix::conf
#
# General postfix main configuration file's inline modification define
# Use with caution, it doesn't fit well with Apache's conf logic based on containers
# Use just for ALREADY DEFINED general settings in main httpd.conf
#
# Usage:
# postfix::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }

define postfix::conf ($value) {

        config { "postfix_conf_$name":
                file      => $operatingsystem ?{
                                default  => "/etc/postfix/main.cf",
                             },
                line      => "$name $value",
                pattern   => "$name ",
                engine    => "replaceline",
                notify    => Service["postfix"],
                require   => File["main.cf"],
                source    => "postfix::conf",
        }

}
