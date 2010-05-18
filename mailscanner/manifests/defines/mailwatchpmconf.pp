# Define mailwatch::pmconf
#
# General mailwatch.pm configuration file's inline modification define
# Use with care! Bugs prone.
#
# Usage:
# mailwatch::pmconf    { "db_host":  value => "localhost" }
#
define mailwatch::pmconf ($value) {

    include mailscanner::params

    config { "mailwatch_pmconf_${name}":
        file      => "${mailscanner::params::custom_functions_dir}/MailWatch.pm",
        line      => "my(\$${name}) = '${value}'; # Modified by Puppet",
        pattern   => "my(\$\\${name})",
        engine    => "replacelinepm",
        require   => Exec["mailwatchpm_copy"],
        source    => "mailwatch::pmconf",
    }

}


define mailwatch::pmconfsql ($value) {

    include mailscanner::params

    config { "mailwatch_pmconfsql_${name}":
        file      => "${mailscanner::params::custom_functions_dir}/SQLBlackWhiteList.pm",
        line      => "my(\$${name}) = '${value}'; # Modified by Puppet",
        pattern   => "my(\$\\${name})",
        engine    => "replacelinepm",
        require   => Exec["sqlblackwhitelist_copy"],
        source    => "mailwatch::pmconfsql",
    }

}
