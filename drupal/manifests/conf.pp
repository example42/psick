# Define drupal::conf
#
# General drupal main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# drupal::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define drupal::conf ($value) {

    require drupal::params

    config { "drupal_conf_$name":
        file      => "${drupal::params::configfile}",
        line      => "$name = $value",
        pattern   => "^$name ",
        engine    => "replaceline",
        notify    => Service["drupal"],
        require   => File["drupal.conf"],
    }

}
