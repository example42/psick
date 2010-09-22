# Define apache::conf
#
# General apache main configuration file's inline modification define
# Use with caution, it doesn't fit well with Apache's conf logic based on containers
# Use just for ALREADY DEFINED general settings in main httpd.conf
#
# Usage:
# apache::conf    { "KeepAlive":  value => "On" }
#
define apache::conf ($value) {

    require apache::params

    config { "apache_conf_$name":
        file      => "${apache::params::configfile}",
        line      => "$name $value",
        pattern   => "$name ",
        engine    => "replaceline",
        notify    => Service["apache"],
        require   => File["httpd.conf"],
        source    => "apache::conf",
    }

}
