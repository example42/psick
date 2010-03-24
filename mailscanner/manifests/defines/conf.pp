# Define mailscanner::conf
#
# General mailscanner main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# mailscanner::conf    { "MTA":  value => "postfix" }

define mailscanner::conf ($value) {

        config { "mailscanner_conf_$name":
                file      => $operatingsystem ?{
                                default  => "/etc/MailScanner/MailScanner.conf",
                             },
                line      => "$name = $value",
                pattern   => "^$name ",
#		parameter => "$name",
#		value     => "$value",
                engine    => "replaceline",
                notify    => Service["mailscanner"],
                require   => File["MailScanner.conf"],
                source    => "mailscanner::conf",
        }

}
