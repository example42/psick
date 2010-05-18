# Define mailwatch::conf
#
# General mailwatch main configuration file's inline modification define
#
# Usage:
# mailwatch::conf    { "DB_HOST":  value => "localhost" }
#
define mailwatch::conf ($value) {

    require mailscanner::params

    config { "mailwatch_conf_${name}":
        file      => "${mailscanner::params::mailwatchconf}",
        line      => "define('${name}', '${value}');",
        pattern   => "define('${name}",
        engine    => "replaceline",
        require   => Exec["mailwatchphpconf_copy"],
        source    => "mailwatch::conf",
    }

}
