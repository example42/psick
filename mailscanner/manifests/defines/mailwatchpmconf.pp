# Define mailwatch::pmconf
#
# General mailwatch.pm configuration file's inline modification define
# Use with care! Bugs prone.
#
# Usage:
# mailwatch::pmconf    { "db_host":  value => "localhost" }

define mailwatch::pmconf ($value , $file="/usr/lib/MailScanner/MailScanner/CustomFunctions/MailWatch.pm") {

        config { "mailwatch_pmconf_${name}":
                file      => $file,
                line      => "my(\$${name}) = '${value}'; # Modified by Puppet",
                pattern   => "my(\$\\${name})",
                engine    => "replacelinepm",
                require   => Exec["mailwatchpm_copy"],
                source    => "mailwatch::pmconf",
        }

}


define mailwatch::pmconfsql ($value , $file="/usr/lib/MailScanner/MailScanner/CustomFunctions/SQLBlackWhiteList.pm") {

        config { "mailwatch_pmconfsql_${name}":
                file      => $file,
                line      => "my(\$${name}) = '${value}'; # Modified by Puppet",
                pattern   => "my(\$\\${name})",
                engine    => "replacelinepm",
                require   => Exec["sqlblackwhitelist_copy"],
                source    => "mailwatch::pmconfsql",
        }

}
