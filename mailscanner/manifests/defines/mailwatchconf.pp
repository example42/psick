# Define mailwatch::conf
#
# General mailwatch main configuration file's inline modification define
#
# Usage:
# mailwatch::conf    { "DB_HOST":  value => "localhost" }

define mailwatch::conf ($value) {

# The path of conf.php file
# This variable is duplicated in mailscanner::mailwatch
$mailwatch_webdir = $operatingsystem ?{
        debian  => "/var/www/mailscanner",
        ubuntu  => "/var/www/mailscanner",
        suse    => "/srv/www/mailscanner",
        default => "/var/www/html/mailscanner",
}
$mailwatchconf = "${mailwatch_webdir}/conf.php"

        config { "mailwatch_conf_${name}":
                file      => $mailwatchconf,
                line      => "define('${name}', '${value}');",
                pattern   => "define('${name}",
                engine    => "replaceline",
                require   => Exec["mailwatchphpconf_copy"],
                source    => "mailwatch::conf",
        }

}
