# Define rsync::conf
#
# General rsync main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# rsync::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define rsync::conf ($value) {

    require rsync::params

    config { "rsync_conf_$name":
        file      => "${rsync::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["rsync"],
        require   => File["rsync.conf"],
    }

}
