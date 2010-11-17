# Define vsftpd::conf
#
# General vsftpd main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# vsftpd::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define vsftpd::conf ($value) {

    require vsftpd::params

    config { "vsftpd_conf_$name":
        file      => "${vsftpd::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["vsftpd"],
        require   => File["vsftpd.conf"],
    }

}
