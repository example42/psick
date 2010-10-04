# Define mysql::conf
#
# General mysql main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Note: This define uses augeas as inline modification engine, so you have to provide the parameter in "augeas style" when referring to sections:
# IE: section/parameter
#
# Usage:
# mysql::conf    {"mysql.server/user":  value => "mysql" }
#
define mysql::conf ($value) {

    config { "mysql_conf_$name":
        file      => $operatingsystem ?{
                default  => "/etc/my.cnf",
                 },
        parameter => "$name",
        value     => "$value",
        engine    => "augeas",
        notify    => Service["mysql"],
        require   => File["my.cnf"],
        source    => "mysql::conf",
    }

}
